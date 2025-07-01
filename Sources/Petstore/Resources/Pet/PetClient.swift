import Foundation

/// Everything about your Pets
public struct PetClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Update an existing pet.
    ///
    /// Update an existing pet by Id.
    public func updatePet(_ data: Pet, requestOptions: RequestOptions? = nil) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .put,
            path: "/pet",
            body: data,
            requestOptions: requestOptions,
            responseType: Pet.self
        )
    }

    /// Add a new pet to the store.
    ///
    /// Add a new pet to the store.
    public func addPet(_ data: Pet, requestOptions: RequestOptions? = nil) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet",
            body: data,
            requestOptions: requestOptions,
            responseType: Pet.self
        )
    }

    /// Deletes a pet.
    ///
    /// Delete a pet.
    /// - Parameter petId: Pet id to delete
    public func deletePet(petId: Int, requestOptions: RequestOptions? = nil) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/pet/\(petId)",
            requestOptions: requestOptions
        )
    }

    /// Finds Pets by status.
    ///
    /// Multiple status values can be provided with comma separated strings.
    /// - Parameters:
    ///   - status: Status values that need to be considered for filter
    ///   - limit: Maximum number of pets to return
    ///   - offset: Number of pets to skip
    public func findPetsByStatus(
        status: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        requestOptions: RequestOptions? = nil
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
            requestOptions: requestOptions,
            responseType: [Pet].self
        )
    }

    /// Finds Pets by tags.
    ///
    /// Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
    /// - Parameter tags: Tags to filter by
    public func findPetsByTags(tags: [String]? = nil, requestOptions: RequestOptions? = nil)
        async throws -> [Pet]
    {
        let queryParams = FindPetsByTags.QueryParams(tags: tags)
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/findByTags",
            queryParams: queryParams.toDictionary(),
            requestOptions: requestOptions,
            responseType: [Pet].self
        )
    }

    /// Find pet by ID.
    ///
    /// Returns a single pet.
    /// - Parameter petId: ID of pet to return
    public func getPetById(petId: Int64, requestOptions: RequestOptions? = nil) async throws -> Pet
    {
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/\(petId)",
            requestOptions: requestOptions,
            responseType: Pet.self
        )
    }

    /// Updates a pet in the store with form data.
    ///
    /// Updates a pet resource based on the form data.
    /// - Parameters:
    ///   - petId: ID of pet that needs to be updated
    ///   - name: Name of pet that needs to be updated
    ///   - status: Status of pet that needs to be updated
    public func updatePetWithForm(
        petId: Int64,
        name: String? = nil,
        status: String? = nil,
        requestOptions: RequestOptions? = nil
    ) async throws -> Pet {
        let queryParams = UpdatePetWithForm.QueryParams(name: name, status: status)
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet/\(petId)",
            queryParams: queryParams.toDictionary(),
            requestOptions: requestOptions,
            responseType: Pet.self
        )
    }

    /// Uploads an image.
    ///
    /// Upload image of the pet.
    /// - Parameters:
    ///   - petId: ID of pet to update
    ///   - fileData: The image file data to upload
    ///   - additionalMetadata: Additional Metadata
    public func uploadFile(
        petId: Int64,
        _ fileData: Data,
        additionalMetadata: String? = nil,
        requestOptions: RequestOptions? = nil
    ) async throws -> ApiResponse {
        let queryParams = UploadFile.QueryParams(additionalMetadata: additionalMetadata)
        return try await httpClient.performFileUpload(
            method: .post,
            path: "/pet/\(petId)/uploadImage",
            queryParams: queryParams.toDictionary(),
            fileData: fileData,
            requestOptions: requestOptions,
            responseType: ApiResponse.self
        )
    }
}
