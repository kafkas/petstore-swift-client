public struct StoreSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func getInventory() async throws -> [String: Int] {
        return try await httpClient.performRequest(
            path: "/store/inventory",
            method: .get,
            responseType: [String: Int].self
        )
    }
}
