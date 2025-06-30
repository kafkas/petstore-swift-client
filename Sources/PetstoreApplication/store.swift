import Foundation
import Petstore

let sampleOrder = Order(
    id: 1,
    petId: 1,
    quantity: 1,
    status: .placed,
    complete: true
)

func getInventory() async {
    print("Getting inventory...")
    do {
        print("Making API request...")
        let inventory = try await client.store.getInventory()
        print("✅ Inventory successfully fetched!")
        print(inventory)
    } catch {
        print("❌ Failed to get inventory: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func placeOrder() async {
    print("Placing order...")
    do {
        print("Making API request...")
        let placedOrder = try await client.store.placeOrder(sampleOrder)
        print("✅ Order successfully placed!")
        print(placedOrder)
    } catch {
        print("❌ Failed to place order: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func getOrderById() async {
    print("Getting order by ID...")
    do {
        print("Making API request...")
        let order = try await client.store.getOrderById(orderId: 1)
        print("✅ Order successfully fetched!")
        print("Order ID: \(order.id ?? 0)")
        print("Pet ID: \(order.petId ?? 0)")
        print("Quantity: \(order.quantity ?? 0)")
        print("Ship Date: \(order.shipDate?.description ?? "no date")")
        print("Status: \(order.status?.rawValue ?? "unknown")")
        print("Complete: \(order.complete ?? false)")
    } catch {
        print("❌ Failed to get order: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}

func deleteOrder() async {
    print("Deleting order...")
    do {
        print("Making API request...")
        try await client.store.deleteOrder(orderId: 1)
        print("✅ Order successfully deleted!")
    } catch {
        print("❌ Failed to delete order: \(error.localizedDescription)")
        if let petstoreError = error as? PetstoreError {
            print("Error type: \(petstoreError)")
        }
    }
}
