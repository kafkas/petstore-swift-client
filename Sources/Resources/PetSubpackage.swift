struct PetSubpackage: Sendable {
    private let httpClient: HTTPClient

    init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    func updatePet(pet: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            path: "/pet",
            method: .put,
            body: pet,
            responseType: Pet.self
        )
    }

    func addPet(pet: Pet) async throws -> Pet {
        return try await httpClient.performRequest(
            path: "/pet",
            method: .post,
            body: pet,
            responseType: Pet.self
        )
    }

    func deletePet(id: Int) async throws {
        try await httpClient.performVoidRequest(
            path: "/pet/\(id)",
            method: .delete
        )
    }
}
