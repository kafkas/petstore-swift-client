import Foundation

func addPetExample() async {
    let client = PetstoreClient(baseURL: "http://localhost:8080")

    let newPet = Pet(
        name: "Fido",
        category: Category(id: 1, name: "Dogs"),
        photoUrls: ["https://example.com/fido.jpg"],
        tags: [Tag(id: 1, name: "friendly")],
        status: .available
    )

    print("Adding pet to the store...")

    do {
        print("Making API request...")
        let createdPet = try await client.pet.addPet(pet: newPet)
        print("✅ Pet successfully added!")
        print("Pet ID: \(createdPet.id ?? 0)")
        print("Pet Name: \(createdPet.name)")
        print("Pet Status: \(createdPet.status?.rawValue ?? "unknown")")

    } catch {
        print("❌ Failed to add pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

Task {
    await addPetExample()
    exit(0)
}

RunLoop.main.run()
