public struct PetstoreClient: Sendable {
    public let pet: PetSubpackage
    public let store: StoreSubpackage

    public init(baseURL: String) {
        self.pet = PetSubpackage(baseURL: baseURL)
        self.store = StoreSubpackage(baseURL: baseURL)
    }
}
