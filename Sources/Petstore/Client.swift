import Foundation

/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
///
/// - Parameters:
///   - baseURL: The base URL to use for requests from the client.
///   - authConfig: The authentication configuration to use for requests from the client. Defaults to `NoAuth()`.
///
/// # Examples
/// ```swift
/// import Petstore
///
/// let client = PetstoreClient(
///     baseURL: "https://petstore3.swagger.io/api/v3",
///     apiKey: "YOUR_API_KEY"
/// )
/// ```
public struct PetstoreClient: Sendable {
    public let pet: PetClient
    public let store: StoreClient
    public let user: UserClient

    public init(
        baseURL: String? = nil,
        environment: PetstoreEnvironment = .default,
        apiKey: String,
        token: String? = nil,
        timeout: Int? = nil,
        headers: [String: String] = [:],
        urlSession: URLSession? = nil
    ) {
        let config = ClientConfig(
            baseURL: baseURL,
            environment: environment,
            apiKey: apiKey,
            token: token,
            timeout: timeout,
            headers: headers,
            urlSession: urlSession
        )
        self.pet = PetClient(config: config)
        self.store = StoreClient(config: config)
        self.user = UserClient(config: config)
    }

}
