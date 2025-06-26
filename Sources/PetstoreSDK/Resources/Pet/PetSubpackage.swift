import Foundation

public struct PetSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func updatePet(pet: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            path: "/pet",
            method: .put,
            body: pet,
            responseType: Pet.self
        )
    }

    public func addPet(pet: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            path: "/pet",
            method: .post,
            body: pet,
            responseType: Pet.self
        )
    }

    public func deletePet(id: Int) async throws {
        try await httpClient.performVoidRequest(
            path: "/pet/\(id)",
            method: .delete
        )
    }

    public func uploadFile(
        petId: Int64,
        fileData: Data,
        additionalMetadata: String? = nil
    ) async throws -> ApiResponse {
        var path = "/pet/\(petId)/uploadImage"
        
        if let metadata = additionalMetadata,
           let encodedMetadata = metadata.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            path += "?additionalMetadata=\(encodedMetadata)"
        }
        
        return try await httpClient.performFileUploadRequest(
            path: path,
            method: .post,
            fileData: fileData,
            responseType: ApiResponse.self
        )
    }
}
