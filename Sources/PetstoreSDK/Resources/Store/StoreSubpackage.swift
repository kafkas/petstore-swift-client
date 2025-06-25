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

    public func placeOrder(order: Order) async throws -> Order {
        return try await httpClient.performRequest(
            path: "/store/order",
            method: .post,
            body: order,
            responseType: Order.self
        )
    }

    public func getOrderById(orderId: Int64) async throws -> Order {
        return try await httpClient.performRequest(
            path: "/store/order/\(orderId)",
            method: .get,
            responseType: Order.self
        )
    }
}
