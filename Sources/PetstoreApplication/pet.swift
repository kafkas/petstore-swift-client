import PetstoreSDK

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
        let createdPet = try await client.pet.addPet(fido)
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
        let updatedPet = try await client.pet.updatePet(newPet)
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
        try await client.pet.deletePet(petId: fido.id!)
        print("✅ Pet successfully deleted!")

    } catch {
        print("❌ Failed to process pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func uploadFile() async {
    print("Uploading file for pet...")
    do {
        print("Creating sample image data...")
        // Create sample binary data (simulating an image file)
        let sampleImageData = "This is sample image data for Fido".data(using: .utf8)!

        print("Making API request...")
        let response = try await client.pet.uploadFile(
            petId: Int64(fido.id!),
            sampleImageData,
            .init(additionalMetadata: "profile picture for Fido")
        )
        print("✅ File successfully uploaded!")
        print("Response code: \(response.code ?? 0)")
        print("Response type: \(response.type ?? "unknown")")
        print("Response message: \(response.message ?? "no message")")

    } catch {
        print("❌ Failed to upload file: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}
