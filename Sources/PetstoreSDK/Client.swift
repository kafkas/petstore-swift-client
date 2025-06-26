public struct PetstoreClient: Sendable {
    public let pet: PetSubpackage
    public let store: StoreSubpackage
    public let user: UserSubpackage

    public init(baseURL: String) {
        self.pet = PetSubpackage(baseURL: baseURL)
        self.store = StoreSubpackage(baseURL: baseURL)
        self.user = UserSubpackage(baseURL: baseURL)
    }
}
