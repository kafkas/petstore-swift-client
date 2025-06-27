import Foundation

public protocol AuthConfiguration: Sendable {
    func authHeaders() -> [String: String]
}

public struct APIKeyAuth: AuthConfiguration {
    private let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func authHeaders() -> [String: String] {
        return ["api_key": apiKey]
    }
}

public struct BearerTokenAuth: AuthConfiguration {
    private let token: String

    public init(token: String) {
        self.token = token
    }

    public func authHeaders() -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }
}

public struct NoAuth: AuthConfiguration {
    public init() {}

    public func authHeaders() -> [String: String] {
        return [:]
    }
}
