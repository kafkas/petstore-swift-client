/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
///
/// - Parameters:
///   - baseURL: The base URL to use for requests from the client. Defaults to `PetstoreEnvironment.default`.
///   - apiKey: The API key for authentication.
///   - token: Bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
///   - headers: Additional custom headers to include with requests. Defaults to empty dictionary.
///   - timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
///   - maxRetries: Maximum number of retries for failed requests. Defaults to 2.
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
///     headers: ["Custom-Header": "value"],
///     timeout: 30,
///     maxRetries: 3,
/// )
/// ```
public final class PetstoreClient: Sendable {
    public let pet: PetClient
    public let store: StoreClient
    public let user: UserClient
    public let veterinary: VeterinaryClient

    private let config: ClientConfig


    public init(
        baseURL: String = PetstoreEnvironment.default.rawValue,
        apiKey: String,
        token: String? = nil,
        headers: [String: String] = [:],
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: URLSession? = nil
    ) {
        self.config = ClientConfig(
            baseURL: baseURL,
            apiKey: apiKey,
            token: token,
            headers: headers,
            timeout: timeout,
            urlSession: urlSession
        )
        self.pet = PetClient(config: self.config)
        self.store = StoreClient(config: self.config)
        self.user = UserClient(config: self.config)
        self.veterinary = VeterinaryClient(config: self.config)
    }
}
