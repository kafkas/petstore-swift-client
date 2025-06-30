import Foundation

public struct UserClient: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.httpClient = HTTPClient(baseURL: baseURL, authConfig: authConfig)
    }

    public func createUser(_ data: User) async throws -> User {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user",
            body: data,
            responseType: User.self
        )
    }

    public func createUsersWithListInput(_ data: [User]) async throws -> User {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user/createWithList",
            body: data,
            responseType: User.self
        )
    }

    public func loginUser(
        username: String? = nil,
        password: String? = nil
    ) async throws -> String {
        let queryParams = LoginUser.QueryParams(username: username, password: password)
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/login",
            queryParams: queryParams.toDictionary(),
            responseType: String.self
        )
    }

    public func logoutUser() async throws {
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/logout"
        )
    }

    public func getUserByName(username: String) async throws -> User {
        return try await httpClient.performRequest(
            method: .get,
            path: "/user/\(username)",
            responseType: User.self
        )
    }

    public func updateUser(username: String, _ data: User) async throws {
        return try await httpClient.performRequest(
            method: .put,
            path: "/user/\(username)",
            body: data
        )
    }

    public func deleteUser(username: String) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/user/\(username)"
        )
    }
}
