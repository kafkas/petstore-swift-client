import Foundation

public struct PetSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func updatePet(pet: Pet) async throws -> Pet {
        return try await httpClient.performJSONRequest(
            method: .put,
            path: "/pet",
            body: pet,
            responseType: Pet.self
        )
    }

    public func addPet(pet: Pet) async throws -> Pet {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/pet",
            body: pet,
            responseType: Pet.self
        )
    }

    public func deletePet(id: Int) async throws {
        try await httpClient.performJSONRequest(
            method: .delete,
            path: "/pet/\(id)"
        )
    }

    public func uploadFile(
        petId: Int64,
        fileData: Data,
        additionalMetadata: String? = nil
    ) async throws -> ApiResponse {
        let path = "/pet/\(petId)/uploadImage"

        var queryParams: [String: String] = [:]

        if let metadata = additionalMetadata {
            queryParams["additionalMetadata"] = metadata
        }

        return try await httpClient.performBinaryRequest(
            method: .post,
            path: path,
            queryParams: queryParams,
            fileData: fileData,
            responseType: ApiResponse.self
        )
    }
}
