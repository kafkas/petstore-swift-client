/// Operations about user
public struct UserClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create user.
    ///
    /// This can only be done by the logged in user.
    public func createUser(request: User, requestOptions: RequestOptions? = nil) async throws
        -> User
    {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user",
            body: request,
            requestOptions: requestOptions,
            responseType: User.self
        )
    }

    /// Creates list of users with given input array.
    ///
    /// Creates list of users with given input array.
    public func createUsersWithListInput(request: [User], requestOptions: RequestOptions? = nil)
        async throws -> User
    {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user/createWithList",
            body: request,
            requestOptions: requestOptions,
            responseType: User.self
        )
    }

    /// Logs user into the system.
    ///
    /// Log into the system.
    /// - Parameters:
    ///   - username: The user name for login
    ///   - password: The password for login in clear text
    public func loginUser(
        username: String? = nil,
        password: String? = nil,
        requestOptions: RequestOptions? = nil
    ) async throws -> String {
        let queryParams = LoginUser.QueryParams(username: username, password: password)
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/login",
            queryParams: queryParams.toDictionary(),
            requestOptions: requestOptions,
            responseType: String.self
        )
    }

    /// Logs out current logged in user session.
    ///
    /// Log user out of the system.
    public func logoutUser(requestOptions: RequestOptions? = nil) async throws {
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/logout",
            requestOptions: requestOptions
        )
    }

    /// Get user by user name.
    ///
    /// Get user detail based on username.
    /// - Parameter username: The name that needs to be fetched. Use user1 for testing
    public func getUserByName(username: String, requestOptions: RequestOptions? = nil) async throws
        -> User
    {
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/\(username)",
            requestOptions: requestOptions,
            responseType: User.self
        )
    }

    /// Update user resource.
    ///
    /// This can only be done by the logged in user.
    /// - Parameters:
    ///   - username: name that need to be deleted
    ///   - data: Update an existent user in the store
    public func updateUser(username: String, request: User, requestOptions: RequestOptions? = nil)
        async throws
    {
        return try await httpClient.performRequest(
            method: .put,
            path: "/user/\(username)",
            body: request,
            requestOptions: requestOptions
        )
    }

    /// Delete user resource.
    ///
    /// This can only be done by the logged in user.
    /// - Parameter username: The name that needs to be deleted
    public func deleteUser(username: String, requestOptions: RequestOptions? = nil) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/user/\(username)",
            requestOptions: requestOptions
        )
    }
}
