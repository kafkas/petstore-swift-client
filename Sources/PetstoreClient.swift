import Foundation

struct PetEndpointGroup {
    let baseURL: String
    private let session = URLSession.shared

    func addPet(pet: Pet, completion: @escaping (Result<Pet, PetstoreError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/pet") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(pet)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.encodingError(error)))
            return
        }

        session.dataTask(with: request) { data, response, error in
            if let error: any Error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200:
                do {
                    let createdPet = try JSONDecoder().decode(Pet.self, from: data)
                    completion(.success(createdPet))
                } catch {
                    completion(.failure(.decodingError(error)))
                }

            case 400:
                completion(.failure(.invalidInput))

            case 422:
                completion(.failure(.validationException))

            default:
                completion(.failure(.httpError(httpResponse.statusCode)))
            }
        }.resume()
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
