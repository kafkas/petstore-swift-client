struct StoreSubpackage: Sendable {
    private let httpClient: HTTPClient

    init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    func getInventory() async throws -> [String: Int] {
        return try await httpClient.performRequest(
            path: "/store/inventory",
            method: .get,
            responseType: [String: Int].self
        )
    }
}
