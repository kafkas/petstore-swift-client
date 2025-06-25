import Foundation

let client = PetstoreClient(baseURL: "http://localhost:8080")

let newPet = Pet(
    name: "Fido",
    category: Category(id: 1, name: "Dogs"),
    photoUrls: ["https://example.com/fido.jpg"],
    tags: [Tag(id: 1, name: "friendly")],
    status: .available
)

print("Adding pet to the store...")

client.pet.addPet(pet: newPet) { result in
    switch result {
    case .success(let createdPet):
        print("✅ Pet successfully added!")
        print("Pet ID: \(createdPet.id ?? 0)")
        print("Pet Name: \(createdPet.name)")
        print("Pet Status: \(createdPet.status?.rawValue ?? "unknown")")

    case .failure(let error):
        print("❌ Failed to add pet: \(error.localizedDescription)")
    }

    // Exit the program
    exit(0)
}

RunLoop.main.run()
