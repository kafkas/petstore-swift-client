import Foundation

struct HTTPClient {
    let baseURL: String
    private let session = URLSession.shared
    private let jsonEncoder = Serde.jsonEncoder
    private let jsonDecoder = Serde.jsonDecoder

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func performJSONRequest<T: Decodable>(
        method: HTTP.Method,
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParams: [String: String] = [:],
        body: (any Encodable)? = nil,
        responseType: T.Type
    ) async throws -> T {
        let requestBody: HTTP.RequestBody? = body.map { .encodable($0) }

        let request = buildRequest(
            method: method,
            contentType: .applicationJson,
            additionalHeaders: additionalHeaders,
            path: path,
            queryParams: queryParams,
            body: requestBody
        )

        let (data, contentType) = try await executeRequestWithURLSession(request)

        if T.self == String.self {
            do {
                return try jsonDecoder.decode(responseType, from: data)
            } catch {
                if contentType?.lowercased().contains("text") == true,
                    let string = String(data: data, encoding: .utf8) as? T
                {
                    return string
                }
                throw PetstoreError.decodingError(error)
            }
        }

        do {
            return try jsonDecoder.decode(responseType, from: data)
        } catch {
            throw PetstoreError.decodingError(error)
        }
    }

    func performJSONRequest(
        method: HTTP.Method,
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParams: [String: String] = [:],
        body: (any Encodable)? = nil
    ) async throws {
        let requestBody: HTTP.RequestBody? = body.map { .encodable($0) }

        let request = buildRequest(
            method: method,
            contentType: .applicationJson,
            additionalHeaders: additionalHeaders,
            path: path,
            queryParams: queryParams,
            body: requestBody
        )
        _ = try await executeRequestWithURLSession(request)
    }

    func performBinaryRequest<T: Decodable>(
        method: HTTP.Method,
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParams: [String: String] = [:],
        fileData: Data,
        responseType: T.Type
    ) async throws -> T {
        let request = buildRequest(
            method: method,
            contentType: .applicationOctetStream,
            additionalHeaders: additionalHeaders,
            path: path,
            queryParams: queryParams,
            body: .data(fileData)
        )
        let (data, _) = try await executeRequestWithURLSession(request)

        do {
            return try jsonDecoder.decode(responseType, from: data)
        } catch {
            throw PetstoreError.decodingError(error)
        }
    }

    private func buildRequest(
        method: HTTP.Method,
        contentType: HTTP.ContentType,
        additionalHeaders: [String: String],
        path: String,
        queryParams: [String: String],
        body: HTTP.RequestBody? = nil
    ) -> URLRequest {
        guard var components: URLComponents = URLComponents(string: baseURL) else {
            precondition(
                false,
                "Invalid base URL '\(baseURL)' - this indicates an unexpected error in the SDK."
            )
        }

        components.path = path

        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let url = components.url else {
            precondition(
                false,
                "Failed to construct URL from components - this indicates an unexpected error in the SDK."
            )
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")

        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body = body {
            switch body {
            case .encodable(let encodableBody):
                do {
                    request.httpBody = try jsonEncoder.encode(encodableBody)
                } catch {
                    precondition(
                        false,
                        "Failed to encode request body: \(error) - this indicates an unexpected error in the SDK."
                    )
                }
            case .data(let dataBody):
                request.httpBody = dataBody
            }
        }

        return request
    }

    private func executeRequestWithURLSession(
        _ request: URLRequest
    ) async throws -> (Data, String?) {
        do {
            print("Executing request: \(request)")
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PetstoreError.invalidResponse
            }

            try handleResponseStatus(httpResponse.statusCode)

            let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type")
            return (data, contentType)

        } catch {
            if error is PetstoreError {
                throw error
            } else {
                throw PetstoreError.networkError(error)
            }
        }
    }

    private func handleResponseStatus(_ statusCode: Int) throws {
        switch statusCode {
        case 200...299:
            return
        case 400:
            throw PetstoreError.invalidInput
        case 404:
            throw PetstoreError.petNotFound
        case 422:
            throw PetstoreError.validationException
        default:
            throw PetstoreError.httpError(statusCode)
        }
    }
}
