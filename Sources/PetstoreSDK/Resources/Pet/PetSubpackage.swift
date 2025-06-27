import Foundation

public struct PetSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func updatePet(_ requestBody: Pet) async throws -> Pet {
        return try await httpClient.performJSONRequest(
            method: .put,
            path: "/pet",
            body: requestBody,
            responseType: Pet.self
        )
    }

    public func addPet(_ requestBody: Pet) async throws -> Pet {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/pet",
            body: requestBody,
            responseType: Pet.self
        )
    }

    public func deletePet(petId: Int) async throws {
        return try await httpClient.performJSONRequest(
            method: .delete,
            path: "/pet/\(petId)"
        )
    }

    public func findPetsByStatus(_ queryParams: FindPetsByStatus.QueryParams) async throws -> [Pet]
    {
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/pet/findByStatus",
            queryParams: queryParams.toDictionary(),
            responseType: [Pet].self
        )
    }

    public func findPetsByTags(_ queryParams: FindPetsByTags.QueryParams) async throws -> [Pet] {
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/pet/findByTags",
            queryParams: queryParams.toDictionary(),
            responseType: [Pet].self
        )
    }

    public func getPetById(petId: Int64) async throws -> Pet {
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/pet/\(petId)",
            responseType: Pet.self
        )
    }

    public func updatePetWithForm(petId: Int64, _ queryParams: UpdatePetWithForm.QueryParams)
        async throws -> Pet
    {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/pet/\(petId)",
            queryParams: queryParams.toDictionary(),
            responseType: Pet.self
        )
    }

    public func uploadFile(
        petId: Int64,
        _ requestBody: Data,
        _ queryParams: UploadFile.QueryParams
    ) async throws -> ApiResponse {
        return try await httpClient.performBinaryRequest(
            method: .post,
            path: "/pet/\(petId)/uploadImage",
            queryParams: queryParams.toDictionary(),
            fileData: requestBody,
            responseType: ApiResponse.self
        )
    }
}
