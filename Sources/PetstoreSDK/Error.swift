import Foundation

public enum PetstoreError: Error, LocalizedError {
    case invalidURL
    case encodingError(Error)
    case decodingError(Error)
    case invalidResponse
    case invalidInput
    case validationException
    case httpError(Int)
    case networkError(Error)
    case petNotFound

    public var errorDescription: String? {
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
