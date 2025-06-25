import Foundation
import PetstoreSDK

let client = PetstoreClient(baseURL: "http://localhost:8080")

Task {
    // Pet methods

    // await addPet()
    // await updatePet()
    // await deletePet()

    // Store methods

    // await getInventory()
    await placeOrder()

    exit(0)
}

RunLoop.main.run()
