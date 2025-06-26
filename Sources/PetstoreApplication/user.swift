import Foundation
import PetstoreSDK

let sampleUser = User(
    id: 123,
    username: "johndoe",
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    password: "secret123",
    phone: "+1-555-123-4567",
    userStatus: 1
)

func createUser() async {
    print("Creating user...")
    do {
        print("Making API request...")
        let createdUser = try await client.user.createUser(user: sampleUser)
        print("✅ User successfully created!")
        print("User ID: \(createdUser.id ?? 0)")
        print("Username: \(createdUser.username ?? "unknown")")
        print("Email: \(createdUser.email ?? "unknown")")
    } catch {
        print("❌ Failed to create user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func createUsersWithListInput() async {
    print("Creating multiple users...")
    do {
        print("Making API request...")
        let users = [
            sampleUser,
            User(
                username: "janedoe", firstName: "Jane", lastName: "Doe", email: "jane@example.com"),
            User(
                username: "bobsmith", firstName: "Bob", lastName: "Smith", email: "bob@example.com"),
        ]
        let result = try await client.user.createUsersWithListInput(users: users)
        print("✅ Users successfully created!")
        print("Result user: \(result.username ?? "unknown")")
    } catch {
        print("❌ Failed to create users: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func loginUser() async {
    print("Logging in user...")
    do {
        print("Making API request...")
        let sessionToken = try await client.user.loginUser(
            username: "user1",
            password: "12345"
        )
        print("✅ User successfully logged in!")
        print("Session token: \(sessionToken)")
    } catch {
        print("❌ Failed to login user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func logoutUser() async {
    print("Logging out user...")
    do {
        print("Making API request...")
        try await client.user.logoutUser()
        print("✅ User successfully logged out!")
    } catch {
        print("❌ Failed to logout user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func getUserByName() async {
    print("Getting user by name...")
    do {
        print("Making API request...")
        let user = try await client.user.getUserByName(username: "johndoe")
        print("✅ User successfully retrieved!")
        print("User ID: \(user.id ?? 0)")
        print("Username: \(user.username ?? "unknown")")
        print("First Name: \(user.firstName ?? "unknown")")
        print("Last Name: \(user.lastName ?? "unknown")")
        print("Email: \(user.email ?? "unknown")")
    } catch {
        print("❌ Failed to get user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func updateUser() async {
    print("Updating user...")
    do {
        print("Making API request...")
        let updatedUser = User(
            id: sampleUser.id,
            username: sampleUser.username,
            firstName: "John Updated",
            lastName: "Doe Updated",
            email: "john.updated@example.com",
            password: sampleUser.password,
            phone: sampleUser.phone,
            userStatus: 2
        )
        try await client.user.updateUser(username: "johndoe", user: updatedUser)
        print("✅ User successfully updated!")
    } catch {
        print("❌ Failed to update user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func deleteUser() async {
    print("Deleting user...")
    do {
        print("Making API request...")
        try await client.user.deleteUser(username: "johndoe")
        print("✅ User successfully deleted!")
    } catch {
        print("❌ Failed to delete user: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}
