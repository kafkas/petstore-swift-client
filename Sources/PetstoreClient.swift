struct PetEndpointGroup {
    func addPet(pet: Pet) {
        fatalError("Not implemented")
    }

    func deletePet(id: Int) {
        fatalError("Not implemented")
    }
}

struct StoreEndpointGroup {
    func deleteOrder(id: Int) {
        fatalError("Not implemented")
    }

    func getInventory() {
        fatalError("Not implemented")
    }

}

struct PetstoreClient {
    let pet = PetEndpointGroup()
    let store = StoreEndpointGroup()
}
