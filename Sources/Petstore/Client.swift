import Foundation

/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
///
/// - Parameters:
///   - baseURL: The base URL to use for requests from the client. If not provided, uses the environment URL.
///   - environment: The environment to use for requests. Defaults to `PetstoreEnvironment.default`.
///   - apiKey: The API key for authentication.
///   - token: Bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
///   - timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
///   - headers: Additional custom headers to include with requests. Defaults to empty dictionary.
///   - urlSession: Custom URLSession to use for requests. If not provided, a default session will be created with the specified timeout.
///
/// # Examples
/// ```swift
/// import Petstore
///
/// // Basic usage with API key
/// let client = PetstoreClient(
///     apiKey: "YOUR_API_KEY"
/// )
///
/// // Advanced usage with custom configuration
/// let client = PetstoreClient(
///     baseURL: "https://custom-petstore.example.com/api/v3",
///     apiKey: "YOUR_API_KEY",
///     token: "YOUR_BEARER_TOKEN",
///     timeout: 30,
///     headers: ["Custom-Header": "value"]
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
