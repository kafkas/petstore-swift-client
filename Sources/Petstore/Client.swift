public struct PetstoreClient: Sendable {
    public let pet: PetClient
    public let store: StoreClient
    public let user: UserClient

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.pet = PetClient(baseURL: baseURL, authConfig: authConfig)
        self.store = StoreClient(baseURL: baseURL, authConfig: authConfig)
        self.user = UserClient(baseURL: baseURL, authConfig: authConfig)
    }
}
