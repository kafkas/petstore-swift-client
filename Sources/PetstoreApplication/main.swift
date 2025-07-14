import Foundation
import Petstore

var client = PetstoreClient(
    baseURL: "http://localhost:8080",
    apiKey: "abc123"
)

Task {
    // Pet methods
    // await addPet()
    // await findPetsByStatus()
    // await findPetsByTags()
    // await getPetById()
    // await updatePet()
    // await updatePetWithForm()
    // await deletePet()
    // await uploadFile()

    // // Store methods
    // await getInventory()
    // await placeOrder()
    // await getOrderById()
    // await deleteOrder()

    // // User methods
    // await createUser()
    // await createUsersWithListInput()
    // await loginUser()
    // await logoutUser()
    // await getUserByName()
    // await updateUser()
    // await deleteUser()

    // // Veterinary methods
    // await createMedicalRecord()
    // await getMedicalRecordsByPetId()
    // await updateMedicalRecord()
    // await createVeterinarianInfo()
    await getVeterinarianById()
    // await scheduleAppointment()
    // await getAppointmentById()

    exit(0)
}

RunLoop.main.run()
