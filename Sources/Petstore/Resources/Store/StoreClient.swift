/// Access to Petstore orders
public struct StoreClient: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.httpClient = HTTPClient(baseURL: baseURL, authConfig: authConfig)
    }

    /// Returns pet inventories by status.
    /// 
    /// Returns a map of status codes to quantities.
    public func getInventory() async throws -> [String: Int] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/inventory",
            responseType: [String: Int].self
        )
    }

    /// Place an order for a pet.
    /// 
    /// Place a new order in the store.
    public func placeOrder(_ data: Order) async throws -> Order {
        return try await httpClient.performRequest(
            method: .post,
            path: "/store/order",
            body: data,
            responseType: Order.self
        )
    }

    /// Find purchase order by ID.
    /// 
    /// For valid response try integer IDs with value <= 5 or > 10. Other values will generate exceptions.
    /// - Parameter orderId: ID of order that needs to be fetched
    public func getOrderById(orderId: Int64) async throws -> Order {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/order/\(orderId)",
            responseType: Order.self
        )
    }
    
    /// Delete purchase order by identifier.
    /// 
    /// For valid response try integer IDs with value < 1000. Anything above 1000 or non-integers will generate API errors.
    /// - Parameter orderId: ID of the order that needs to be deleted
    public func deleteOrder(orderId: Int64) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/store/order/\(orderId)"
        )
    }
}
