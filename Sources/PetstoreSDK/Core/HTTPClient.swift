import Foundation

struct HTTPClient {
    let baseURL: String
    private let session = URLSession.shared
    private let jsonEncoder = Serde.jsonEncoder
    private let jsonDecoder = Serde.jsonDecoder

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func performRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil,
        responseType: T.Type
    ) async throws -> T {
        let (data, contentType) = try await executeRequestWithContentType(
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
        contentType: String = "application/octet-stream",
        responseType: T.Type
    ) async throws -> T {
        let data = try await executeFileUploadRequest(
            path: path,
            method: method,
            fileData: fileData,
            contentType: contentType
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
    ) async throws -> Data {
        let (data, _) = try await executeRequestWithContentType(
            path: path, method: method, body: body)
        return data
    }

    private func executeRequestWithContentType(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil
    ) async throws -> (Data, String?) {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
        fileData: Data,
        contentType: String
    ) async throws -> Data {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
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
