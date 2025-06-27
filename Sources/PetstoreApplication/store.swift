import Foundation
import PetstoreSDK

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

func placeOrder() async {
    print("Placing order...")
    do {
        print("Making API request...")
        let order = Order(
            id: 1,
            petId: 1,
            quantity: 1,
            shipDate: Date(),
            status: .placed,
            complete: true
        )
        let placedOrder = try await client.store.placeOrder(order)
        print("✅ Order successfully placed!")
        print(placedOrder)
    } catch {
        print("❌ Failed to process order: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func getOrderById() async {
    print("Getting order by ID...")
    do {
        print("Making API request...")
        let orderId: Int64 = 1
        let order = try await client.store.getOrderById(orderId: orderId)
        print("✅ Order successfully fetched!")
        print("Order ID: \(order.id ?? 0)")
        print("Pet ID: \(order.petId ?? 0)")
        print("Quantity: \(order.quantity ?? 0)")
        print("Ship Date: \(order.shipDate ?? Date())")
        print("Status: \(order.status?.rawValue ?? "unknown")")
        print("Complete: \(order.complete ?? false)")
    } catch {
        print("❌ Failed to get order: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}
