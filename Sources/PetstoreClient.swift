import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct PetSubpackage {
    let baseURL: String
    private let session = URLSession.shared
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Public API methods

    func updatePet(pet: Pet) async throws -> Pet {
        return try await performRequest(
            path: "/pet",
            method: .put,
            body: pet,
            responseType: Pet.self
        )
    }

    func addPet(pet: Pet) async throws -> Pet {
        return try await performRequest(
            path: "/pet",
            method: .post,
            body: pet,
            responseType: Pet.self
        )
    }

    func deletePet(id: Int) async throws {
        try await performVoidRequest(
            path: "/pet/\(id)",
            method: .delete
        )
    }

    // MARK: - Private methods

    private func performRequest<T: Decodable>(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil,
        responseType: T.Type
    ) async throws -> T {
        let data = try await executeRequest(path: path, method: method, body: body)

        do {
            return try decoder.decode(responseType, from: data)
        } catch {
            throw PetstoreError.decodingError(error)
        }
    }

    private func performVoidRequest(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil
    ) async throws {
        _ = try await executeRequest(path: path, method: method, body: body)
    }

    private func executeRequest(
        path: String,
        method: HTTPMethod,
        body: (any Encodable)? = nil
    ) async throws -> Data {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try encoder.encode(body)
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

// Custom error types for better error handling
enum PetstoreError: Error, LocalizedError {
    case invalidURL
    case encodingError(Error)
    case decodingError(Error)
    case invalidResponse
    case invalidInput
    case validationException
    case httpError(Int)
    case networkError(Error)
    case petNotFound

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .encodingError(let error):
            return "Failed to encode request: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response received"
        case .invalidInput:
            return "Invalid input provided"
        case .validationException:
            return "Validation exception occurred"
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .petNotFound:
            return "Pet not found"
        }
    }
}

struct StoreSubpackage {
    let baseURL: String

    func deleteOrder(id: Int) {
        fatalError("Not implemented")
    }

    func getInventory() {
        fatalError("Not implemented")
    }

}

struct PetstoreClient {
    let pet: PetSubpackage
    let store: StoreSubpackage

    init(baseURL: String) {
        self.pet = PetSubpackage(baseURL: baseURL)
        self.store = StoreSubpackage(baseURL: baseURL)
    }
}
