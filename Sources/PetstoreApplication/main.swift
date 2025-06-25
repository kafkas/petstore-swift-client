import Foundation
import PetstoreSDK

let client = PetstoreClient(baseURL: "http://localhost:8080")

let fido = Pet(
    id: 1,
    name: "Fido",
    category: Category(id: 1, name: "Dogs"),
    photoUrls: ["https://example.com/fido.jpg"],
    tags: [Tag(id: 1, name: "friendly")],
    status: .available
)

func addPet() async {
    print("Adding pet to the store...")

    do {
        print("Making API request...")
        let createdPet = try await client.pet.addPet(pet: fido)
        print("✅ Pet successfully added!")
        print("Pet ID: \(createdPet.id ?? 0)")
        print("Pet Name: \(createdPet.name)")
        print("Pet Status: \(createdPet.status?.rawValue ?? "unknown")")
    } catch {
        print("❌ Failed to process pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func updatePet() async {
    let newPet: Pet = Pet(
        id: fido.id,
        name: fido.name,
        photoUrls: fido.photoUrls,
        status: .sold
    )

    print("Updating pet status to 'sold'...")

    do {
        print("Making API request...")
        let updatedPet = try await client.pet.updatePet(pet: newPet)
        print("✅ Pet successfully updated!")
        print("Pet ID: \(updatedPet.id ?? 0)")
        print("Pet Name: \(updatedPet.name)")
        print("Pet Status: \(updatedPet.status?.rawValue ?? "unknown")")

    } catch {
        print("❌ Failed to process pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func deletePet() async {
    print("Deleting pet...")
    do {
        print("Making API request...")
        try await client.pet.deletePet(id: fido.id!)
        print("✅ Pet successfully deleted!")

    } catch {
        print("❌ Failed to process pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func getInventory() async {
    print("Getting inventory...")
    do {
        print("Making API request...")
        let inventory = try await client.store.getInventory()
        print("✅ Inventory successfully fetched!")
        print(inventory)

    } catch {
        print("❌ Failed to process pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

Task {
    // await addPet()
    // await updatePet()
    // await deletePet()
    await getInventory()
    exit(0)
}

RunLoop.main.run()
