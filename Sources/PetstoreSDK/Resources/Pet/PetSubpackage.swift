import Foundation

public struct PetSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.httpClient = HTTPClient(baseURL: baseURL, authConfig: authConfig)
    }

    public func updatePet(_ data: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .put,
            path: "/pet",
            body: data,
            responseType: Pet.self
        )
    }

    public func addPet(_ data: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet",
            body: data,
            responseType: Pet.self
        )
    }

    public func deletePet(petId: Int) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/pet/\(petId)"
        )
    }

    public func findPetsByStatus(
        status: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) async throws -> [Pet] {
        let queryParams = FindPetsByStatus.QueryParams(
            status: status,
            limit: limit,
            offset: offset
        )
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/findByStatus",
            queryParams: queryParams.toDictionary(),
            responseType: [Pet].self
        )
    }

    public func findPetsByTags(tags: [String]? = nil) async throws -> [Pet] {
        let queryParams = FindPetsByTags.QueryParams(tags: tags)
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/findByTags",
            queryParams: queryParams.toDictionary(),
            responseType: [Pet].self
        )
    }

    public func getPetById(petId: Int64) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/\(petId)",
            responseType: Pet.self
        )
    }

    public func updatePetWithForm(
        petId: Int64,
        name: String? = nil,
        status: String? = nil
    ) async throws -> Pet {
        let queryParams = UpdatePetWithForm.QueryParams(name: name, status: status)
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet/\(petId)",
            queryParams: queryParams.toDictionary(),
            responseType: Pet.self
        )
    }

    public func uploadFile(
        petId: Int64,
        _ fileData: Data,
        additionalMetadata: String? = nil
    ) async throws -> ApiResponse {
        let queryParams = UploadFile.QueryParams(additionalMetadata: additionalMetadata)
        return try await httpClient.performFileUpload(
            method: .post,
            path: "/pet/\(petId)/uploadImage",
            queryParams: queryParams.toDictionary(),
            fileData: fileData,
            responseType: ApiResponse.self
        )
    }
}
