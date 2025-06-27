public struct PetstoreClient: Sendable {
    public let pet: PetSubpackage
    public let store: StoreSubpackage
    public let user: UserSubpackage

    public init(baseURL: String, authConfig: AuthConfiguration = NoAuth()) {
        self.pet = PetSubpackage(baseURL: baseURL, authConfig: authConfig)
        self.store = StoreSubpackage(baseURL: baseURL, authConfig: authConfig)
        self.user = UserSubpackage(baseURL: baseURL, authConfig: authConfig)
    }
}
