import Foundation

public struct UserSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func createUser(user: User) async throws -> User {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/user",
            body: user,
            responseType: User.self
        )
    }

    public func createUsersWithListInput(users: [User]) async throws -> User {
        return try await httpClient.performJSONRequest(
            method: .post,
            path: "/user/createWithList",
            body: users,
            responseType: User.self
        )
    }

    public func loginUser(username: String?, password: String?) async throws -> String {
        var path = "/user/login"
        var queryParams: [String] = []

        if let username = username?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            queryParams.append("username=\(username)")
        }

        if let password = password?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            queryParams.append("password=\(password)")
        }

        if !queryParams.isEmpty {
            path += "?" + queryParams.joined(separator: "&")
        }

        return try await httpClient.performJSONRequest(
            method: .get,
            path: path,
            responseType: String.self
        )
    }

    public func logoutUser() async throws {
        try await httpClient.performJSONRequest(
            method: .get,
            path: "/user/logout"
        )
    }

    public func getUserByName(username: String) async throws -> User {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        return try await httpClient.performJSONRequest(
            method: .get,
            path: "/user/\(encodedUsername)",
            responseType: User.self
        )
    }

    public func updateUser(username: String, user: User) async throws {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        try await httpClient.performJSONRequest(
            method: .put,
            path: "/user/\(encodedUsername)",
            body: user
        )
    }

    public func deleteUser(username: String) async throws {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        try await httpClient.performJSONRequest(
            method: .delete,
            path: "/user/\(encodedUsername)"
        )
    }
}
