import Petstore

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

func findPetsByStatus() async {
    print("Finding pets by status...")
    do {
        print("Making API request...")
        let pets = try await client.pet.findPetsByStatus(status: "available")
        print("✅ Pets successfully found!")
        print("Found \(pets.count) available pets")
        for pet in pets.prefix(3) {
            print("Pet: \(pet.name) - Status: \(pet.status?.rawValue ?? "unknown")")
        }
    } catch {
        print("❌ Failed to find pets: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func findPetsByTags() async {
    print("Finding pets by tags...")
    do {
        print("Making API request...")
        let pets = try await client.pet.findPetsByTags(tags: ["friendly", "cute"])
        print("✅ Pets successfully found!")
        print("Found \(pets.count) pets with specified tags")
        for pet in pets.prefix(3) {
            print(
                "Pet: \(pet.name) - Tags: \(pet.tags?.map { $0.name ?? "no name" }.joined(separator: ", ") ?? "no tags")"
            )
        }
    } catch {
        print("❌ Failed to find pets: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func getPetById() async {
    print("Getting pet by ID...")
    do {
        print("Making API request...")
        let pet = try await client.pet.getPetById(petId: Int64(fido.id!))
        print("✅ Pet successfully retrieved!")
        print("Pet ID: \(pet.id ?? 0)")
        print("Pet Name: \(pet.name)")
        print("Pet Status: \(pet.status?.rawValue ?? "unknown")")
    } catch {
        print("❌ Failed to get pet: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func updatePetWithForm() async {
    print("Updating pet with form data...")
    do {
        print("Making API request...")
        let updatedPet = try await client.pet.updatePetWithForm(
            petId: Int64(fido.id!),
            name: "Super Fido",
            status: "available"
        )
        print("✅ Pet successfully updated with form!")
        print("Pet ID: \(updatedPet.id ?? 0)")
        print("Pet Name: \(updatedPet.name)")
        print("Pet Status: \(updatedPet.status?.rawValue ?? "unknown")")
    } catch {
        print("❌ Failed to update pet with form: \(error.localizedDescription)")
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
            additionalMetadata: "Profile picture for Fido"
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
