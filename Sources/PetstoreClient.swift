import Foundation

struct PetEndpointGroup {
    let baseURL: String
    private let session = URLSession.shared

    func addPet(pet: Pet) async throws -> Pet {
        guard let url = URL(string: "\(baseURL)/pet") else {
            throw PetstoreError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(pet)
            request.httpBody = jsonData
        } catch {
            throw PetstoreError.encodingError(error)
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PetstoreError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200:
                do {
                    let createdPet = try JSONDecoder().decode(Pet.self, from: data)
                    return createdPet
                } catch {
                    throw PetstoreError.decodingError(error)
                }

            case 400:
                throw PetstoreError.invalidInput

            case 422:
                throw PetstoreError.validationException

            default:
                throw PetstoreError.httpError(httpResponse.statusCode)
            }

        } catch {
            if error is PetstoreError {
                throw error
            } else {
                throw PetstoreError.networkError(error)
            }
        }
    }

    func deletePet(id: Int) {
        fatalError("Not implemented")
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
        }
    }
}

struct StoreEndpointGroup {
    let baseURL: String

    func deleteOrder(id: Int) {
        fatalError("Not implemented")
    }

    func getInventory() {
        fatalError("Not implemented")
    }

}

struct PetstoreClient {
    let pet: PetEndpointGroup
    let store: StoreEndpointGroup

    init(baseURL: String) {
        self.pet = PetEndpointGroup(baseURL: baseURL)
        self.store = StoreEndpointGroup(baseURL: baseURL)
    }
}
