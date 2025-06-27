import Foundation

public struct UserSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.httpClient = HTTPClient(baseURL: baseURL, authConfig: authConfig)
    }

    public func createUser(_ requestBody: User) async throws -> User {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user",
            body: requestBody,
            responseType: User.self
        )
    }

    public func createUsersWithListInput(_ requestBody: [User]) async throws -> User {
        return try await httpClient.performRequest(
            method: .post,
            path: "/user/createWithList",
            body: requestBody,
            responseType: User.self
        )
    }

    public func loginUser(_ queryParams: LoginUser.QueryParams) async throws -> String {
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

    public func updateUser(username: String, _ requestBody: User) async throws {
        return try await httpClient.performRequest(
            method: .put,
            path: "/user/\(username)",
            body: requestBody
        )
    }

    public func deleteUser(username: String) async throws {
        return try await httpClient.performRequest(
            method: .delete,
            path: "/user/\(username)"
        )
    }
}
