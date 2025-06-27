import Foundation

struct HTTPClient {
    let baseURL: String
    private let authConfig: AuthConfiguration
    private let session = URLSession.shared
    private let jsonEncoder = Serde.jsonEncoder
    private let jsonDecoder = Serde.jsonDecoder

    init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.baseURL = baseURL
        self.authConfig = authConfig
    }

    func performRequest<T: Decodable>(
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

    func performRequest(
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

    func performFileUpload<T: Decodable>(
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

        // Add authentication headers
        let authHeaders = authConfig.authHeaders()
        for (key, value) in authHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Add additional headers (these can override auth headers if needed)
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
            print("Executing request: \(request)")  // For debugging

            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PetstoreError.invalidResponse
            }

            // Handle successful responses
            if 200...299 ~= httpResponse.statusCode {
                let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type")
                return (data, contentType)
            }

            // Handle error responses
            try handleErrorResponse(
                statusCode: httpResponse.statusCode,
                data: data
            )

            // This should never be reached, but satisfy the compiler
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

    private func handleErrorResponse(statusCode: Int, data: Data) throws {
        let errorResponse = parseErrorResponse(statusCode: statusCode, from: data)

        switch statusCode {
        case 400:
            throw PetstoreError.badRequest(errorResponse)
        case 401:
            throw PetstoreError.unauthorized(errorResponse)
        case 403:
            throw PetstoreError.forbidden(errorResponse)
        case 404:
            throw PetstoreError.notFound(errorResponse)
        case 422:
            throw PetstoreError.validationError(errorResponse)
        case 500...599:
            throw PetstoreError.serverError(errorResponse)
        default:
            throw PetstoreError.httpError(statusCode: statusCode, response: errorResponse)
        }
    }

    private func parseErrorResponse(statusCode: Int, from data: Data) -> APIErrorResponse? {
        // Try to parse as JSON error response first
        if let errorResponse = try? jsonDecoder.decode(APIErrorResponse.self, from: data) {
            return errorResponse
        }

        // Try to parse as simple JSON with message field
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let message = json["message"] as? String
        {
            return APIErrorResponse(code: statusCode, message: message)
        }

        // Try to parse as plain text
        if let errorMessage = String(data: data, encoding: .utf8), !errorMessage.isEmpty {
            return APIErrorResponse(code: statusCode, message: errorMessage)
        }

        return nil
    }
}
