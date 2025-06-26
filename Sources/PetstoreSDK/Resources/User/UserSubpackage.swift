import Foundation

public struct UserSubpackage: Sendable {
    private let httpClient: HTTPClient

    public init(baseURL: String) {
        self.httpClient = HTTPClient(baseURL: baseURL)
    }

    public func createUser(user: User) async throws -> User {
        return try await httpClient.performRequest(
            path: "/user",
            method: .post,
            body: user,
            responseType: User.self
        )
    }

    public func createUsersWithListInput(users: [User]) async throws -> User {
        return try await httpClient.performRequest(
            path: "/user/createWithList",
            method: .post,
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

        return try await httpClient.performRequest(
            path: path,
            method: .get,
            responseType: String.self
        )
    }

    public func logoutUser() async throws {
        try await httpClient.performVoidRequest(
            path: "/user/logout",
            method: .get
        )
    }

    public func getUserByName(username: String) async throws -> User {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        return try await httpClient.performRequest(
            path: "/user/\(encodedUsername)",
            method: .get,
            responseType: User.self
        )
    }

    public func updateUser(username: String, user: User) async throws {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        try await httpClient.performVoidRequest(
            path: "/user/\(encodedUsername)",
            method: .put,
            body: user
        )
    }

    public func deleteUser(username: String) async throws {
        let encodedUsername =
            username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        try await httpClient.performVoidRequest(
            path: "/user/\(encodedUsername)",
            method: .delete,
        )
    }
}
