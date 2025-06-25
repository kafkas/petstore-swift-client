struct PetstoreClient: Sendable {
    let pet: PetSubpackage
    let store: StoreSubpackage

    init(baseURL: String) {
        self.pet = PetSubpackage(baseURL: baseURL)
        self.store = StoreSubpackage(baseURL: baseURL)
    }
}
