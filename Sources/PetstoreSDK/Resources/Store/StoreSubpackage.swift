public struct StoreSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func getInventory() async throws -> [String: Int] {
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/store/inventory",
            responseType: [String: Int].self
        )
    }

    public func placeOrder(_ requestBody: Order) async throws -> Order {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/store/order",
            body: requestBody,
            responseType: Order.self
        )
    }

    public func getOrderById(orderId: Int64) async throws -> Order {
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/store/order/\(orderId)",
            responseType: Order.self
        )
    }
}
