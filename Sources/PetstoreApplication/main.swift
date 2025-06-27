import Foundation
import PetstoreSDK

let client = PetstoreClient(
    baseURL: "http://localhost:8080",
    authConfig: NoAuth()
)

Task {
    // Pet methods
    await addPet()
    await findPetsByStatus()
    await findPetsByTags()
    await getPetById()
    await updatePet()
    await updatePetWithForm()
    await deletePet()
    await uploadFile()

    // Store methods
    await getInventory()
    await placeOrder()
    await getOrderById()
    await deleteOrder()

    // User methods
    await createUser()
    await createUsersWithListInput()
    await loginUser()
    await logoutUser()
    await getUserByName()
    await updateUser()
    await deleteUser()

    exit(0)
}

RunLoop.main.run()
