public struct StoreSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.httpClient = HTTPClient(baseURL: baseURL, authConfig: authConfig)
    }

    public func getInventory() async throws -> [String: Int] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/inventory",
            responseType: [String: Int].self
        )
    }

    public func placeOrder(_ data: Order) async throws -> Order {
        return try await httpClient.performRequest(
            method: .post,
            path: "/store/order",
            body: data,
            responseType: Order.self
        )
    }

    public func getOrderById(orderId: Int64) async throws -> Order {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/order/\(orderId)",
            responseType: Order.self
        )
    }
    
    public func deleteOrder(orderId: Int64) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/store/order/\(orderId)"
        )
    }
}
