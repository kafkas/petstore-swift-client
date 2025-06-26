import Foundation

struct HTTPClient {
    let baseURL: String
    private let session = URLSession.shared
    private let jsonEncoder = Serde.jsonEncoder
    private let jsonDecoder = Serde.jsonDecoder

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func buildRequest(
        method: HTTPMethod,
        contentType: MIMEType,
        additionalHeaders: [String: String],
        path: String,
        queryParams: [String: String],
        body: (any Encodable)? = nil
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
            do {
                request.httpBody = try jsonEncoder.encode(body)
            } catch {
                precondition(
                    false,
                    "Failed to encode request body: \(error) - this indicates a bug in Fern's code generation"
                )
            }
        }

        return request
    }

    func performRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil,
        responseType: T.Type
    ) async throws -> T {
        let (data, contentType) = try await executeRequest(
            path: path, method: method, body: body)

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

    func performVoidRequest(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil
    ) async throws {
        _ = try await executeRequest(path: path, method: method, body: body)
    }

    func performFileUploadRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        fileData: Data,
        responseType: T.Type
    ) async throws -> T {
        let data = try await executeFileUploadRequest(
            path: path,
            method: method,
            fileData: fileData
        )

        do {
            return try jsonDecoder.decode(responseType, from: data)
        } catch {
            throw PetstoreError.decodingError(error)
        }
    }

    private func executeRequest(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil
    ) async throws -> (Data, String?) {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
        let contentType = "application/json"
        request.httpMethod = method.rawValue
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        if let body = body {
            do {
                request.httpBody = try jsonEncoder.encode(body)
            } catch {
                throw PetstoreError.encodingError(error)
            }
        }

        do {
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

    private func executeFileUploadRequest(
        path: String,
        method: HTTPMethod,
        fileData: Data
    ) async throws -> Data {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
        let contentType = "application/octet-stream"
        request.httpMethod = method.rawValue
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = fileData

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PetstoreError.invalidResponse
            }

            try handleResponseStatus(httpResponse.statusCode)

            return data

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
