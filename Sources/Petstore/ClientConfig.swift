import Foundation

public struct ClientConfig: Sendable {
    struct Defaults {
        static let timeout: Int = 60
    }

    let baseURL: String
    let apiKey: String?
    let token: String?
    let headers: [String: String]?
    let urlSession: URLSession

    init(
        baseURL: String? = nil,
        environment: PetstoreEnvironment,
        apiKey: String? = nil,
        token: String? = nil,
        timeout: Int? = nil,
        headers: [String: String]? = nil,
        urlSession: URLSession? = nil
    ) {
        self.baseURL = getBaseURL(baseURL: baseURL, environment: environment)
        self.apiKey = apiKey
        self.token = token
        self.headers = headers
        self.urlSession = urlSession ?? buildURLSession(timeoutSeconds: timeout)
    }

}

private func buildURLSession(timeoutSeconds: Int?) -> URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = .init(timeoutSeconds ?? ClientConfig.Defaults.timeout)
    return .init(configuration: configuration)
}

private func getBaseURL(baseURL: String?, environment: PetstoreEnvironment) -> String {
    if let baseURL = baseURL {
        return baseURL
    }
    return environment.rawValue
}
