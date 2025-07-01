/// Access to Petstore orders
public struct StoreClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Returns pet inventories by status.
    ///
    /// Returns a map of status codes to quantities.
    public func getInventory(requestOptions: RequestOptions? = nil) async throws -> [String: Int] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/inventory",
            requestOptions: requestOptions,
            responseType: [String: Int].self
        )
    }

    /// Place an order for a pet.
    ///
    /// Place a new order in the store.
    public func placeOrder(_ data: Order, requestOptions: RequestOptions? = nil) async throws -> Order {
        return try await httpClient.performRequest(
            method: .post,
            path: "/store/order",
            body: data,
            requestOptions: requestOptions,
            responseType: Order.self
        )
    }

    /// Find purchase order by ID.
    ///
    /// For valid response try integer IDs with value <= 5 or > 10. Other values will generate exceptions.
    /// - Parameter orderId: ID of order that needs to be fetched
    public func getOrderById(orderId: Int64, requestOptions: RequestOptions? = nil) async throws -> Order {
        return try await httpClient.performRequest(
            method: .get,
            path: "/store/order/\(orderId)",
            requestOptions: requestOptions,
            responseType: Order.self
        )
    }

    /// Delete purchase order by identifier.
    ///
    /// For valid response try integer IDs with value < 1000. Anything above 1000 or non-integers will generate API errors.
    /// - Parameter orderId: ID of the order that needs to be deleted
    public func deleteOrder(orderId: Int64, requestOptions: RequestOptions? = nil) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/store/order/\(orderId)",
            requestOptions: requestOptions
        )
    }
}
