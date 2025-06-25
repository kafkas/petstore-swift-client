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
}
