import Foundation

public struct VaccinationRecord: Codable, Hashable, Sendable {
    public let recordType: String = "vaccination"
    public let id: Int64?
    public let petId: Int64
    public let veterinarianId: Int64
    public let createdAt: Date
    public let updatedAt: Date?
    public let urgencyLevel: UrgencyLevel?
    public let notes: String?
    public let vaccineName: String
    public let vaccinationDate: Date
    public let nextDueDate: Date
    public let vaccinationSite: String?

    public init(
        id: Int64? = nil,
        petId: Int64,
        veterinarianId: Int64,
        createdAt: Date,
        updatedAt: Date? = nil,
        urgencyLevel: UrgencyLevel? = nil,
        notes: String? = nil,
        vaccineName: String,
        vaccinationDate: Date,
        nextDueDate: Date,
        vaccinationSite: String? = nil
    ) {
        self.id = id
        self.petId = petId
        self.veterinarianId = veterinarianId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.urgencyLevel = urgencyLevel
        self.notes = notes
        self.vaccineName = vaccineName
        self.vaccinationDate = vaccinationDate
        self.nextDueDate = nextDueDate
        self.vaccinationSite = vaccinationSite
    }

    enum CodingKeys: String, CodingKey {
        case recordType = "record_type"
        case id
        case petId = "pet_id"
        case veterinarianId = "veterinarian_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case urgencyLevel = "urgency_level"
        case notes
        case vaccineName = "vaccine_name"
        case vaccinationDate = "vaccination_date"
        case nextDueDate = "next_due_date"
        case vaccinationSite = "vaccination_site"
    }
}
