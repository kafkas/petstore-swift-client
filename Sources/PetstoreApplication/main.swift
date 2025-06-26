import Foundation
import PetstoreSDK

let client = PetstoreClient(baseURL: "http://localhost:8080")

Task {
    // Pet methods

    // await addPet()
    // await updatePet()
    // await deletePet()
    await uploadFile()

    // Store methods

    // await getInventory()
    // await placeOrder()
    // await getOrderById()

    exit(0)
}

RunLoop.main.run()
