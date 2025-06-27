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

    public func uploadFile(
        petId: Int64,
        _ requestBody: Data,
        _ queryParams: UploadFile.QueryParams
    ) async throws -> ApiResponse {
        let path = "/pet/\(petId)/uploadImage"

        return try await httpClient.performBinaryRequest(
            method: .post,
            path: path,
            queryParams: queryParams.toDictionary(),
            fileData: requestBody,
            responseType: ApiResponse.self
        )
    }
}
