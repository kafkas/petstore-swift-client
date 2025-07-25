/// Everything about your Pets
public final class PetClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Update an existing pet.
    ///
    /// Update an existing pet by Id.
    public func updatePet(request: Pet, requestOptions: RequestOptions? = nil) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .put,
            path: "/pet",
            body: request,
            requestOptions: requestOptions,
            responseType: Pet.self
        )
    }

    /// Add a new pet to the store.
    ///
    /// Add a new pet to the store.
    public func addPet(request: Pet, requestOptions: RequestOptions? = nil) async throws -> Pet {
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet",
            body: request,
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
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/findByStatus",
            queryParams: [
                "status": status.map { .string($0) },
                "limit": limit.map { .int($0) },
                "offset": offset.map { .int($0) },
            ],
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
        return try await httpClient.performRequest(
            method: .get,
            path: "/pet/findByTags",
            queryParams: [
                "tags": tags.map { .stringArray($0) }
            ],
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
        return try await httpClient.performRequest(
            method: .post,
            path: "/pet/\(petId)",
            queryParams: [
                "name": name.map { .string($0) },
                "status": status.map { .string($0) },
            ],
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
        _ request: Data,
        additionalMetadata: String? = nil,
        requestOptions: RequestOptions? = nil
    ) async throws -> ApiResponse {
        return try await httpClient.performFileUpload(
            method: .post,
            path: "/pet/\(petId)/uploadImage",
            queryParams: [
                "additionalMetadata": additionalMetadata.map { .string($0) }
            ],
            fileData: request,
            requestOptions: requestOptions,
            responseType: ApiResponse.self
        )
    }
}
