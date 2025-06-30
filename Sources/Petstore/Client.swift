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
///     authConfig: ApiKeyAuth(apiKey: "YOUR_API_KEY")
/// )
/// ```
public struct PetstoreClient: Sendable {
    public let pet: PetClient
    public let store: StoreClient
    public let user: UserClient

    public init(
        baseURL: String? = nil,
        environment: PetstoreEnvironment = .default,
        apiKey: String
    ) {
        let baseURL = getBaseURL(baseURL: baseURL, environment: environment)

        self.pet = PetClient(baseURL: baseURL, apiKey: apiKey)
        self.store = StoreClient(baseURL: baseURL, apiKey: apiKey)
        self.user = UserClient(baseURL: baseURL, apiKey: apiKey)
    }

}

private func getBaseURL(baseURL: String?, environment: PetstoreEnvironment) -> String {
    if let baseURL = baseURL {
        return baseURL
    }
    return environment.rawValue
}
