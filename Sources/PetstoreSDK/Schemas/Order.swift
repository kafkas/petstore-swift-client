import Foundation

public struct Order: Codable, Sendable {
    public let id: Int64?
    public let petId: Int64?
    public let quantity: Int32?
    public let shipDate: Date?
    public let status: Status?
    public let complete: Bool?

    public enum Status: String, Codable, CaseIterable, Sendable {
        case placed = "placed"
        case approved = "approved"
        case delivered = "delivered"
    }

    public init(
        id: Int64? = nil,
        petId: Int64? = nil,
        quantity: Int32? = nil,
        shipDate: Date? = nil,
        status: Status? = nil,
        complete: Bool? = nil
    ) {
        self.id = id
        self.petId = petId
        self.quantity = quantity
        self.shipDate = shipDate
        self.status = status
        self.complete = complete
    }
}
