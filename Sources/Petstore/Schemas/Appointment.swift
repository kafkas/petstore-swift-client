import Foundation

public struct Appointment: Codable, Hashable, Sendable {
    public let id: Int64?
    public let petId: Int64
    public let veterinarianId: Int64
    public let appointmentDate: Date
    public let appointmentStatus: AppointmentStatus
    public let urgencyLevel: UrgencyLevel?
    public let reasonForVisit: String?
    public let estimatedDurationMinutes: Int?
    public let specialInstructions: String?
    public let createdAt: Date?
    public let updatedAt: Date?

    public init(
        id: Int64? = nil,
        petId: Int64,
        veterinarianId: Int64,
        appointmentDate: Date,
        appointmentStatus: AppointmentStatus,
        urgencyLevel: UrgencyLevel? = nil,
        reasonForVisit: String? = nil,
        estimatedDurationMinutes: Int? = nil,
        specialInstructions: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.petId = petId
        self.veterinarianId = veterinarianId
        self.appointmentDate = appointmentDate
        self.appointmentStatus = appointmentStatus
        self.urgencyLevel = urgencyLevel
        self.reasonForVisit = reasonForVisit
        self.estimatedDurationMinutes = estimatedDurationMinutes
        self.specialInstructions = specialInstructions
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case petId = "pet_id"
        case veterinarianId = "veterinarian_id"
        case appointmentDate = "appointment_date"
        case appointmentStatus = "appointment_status"
        case urgencyLevel = "urgency_level"
        case reasonForVisit = "reason_for_visit"
        case estimatedDurationMinutes = "estimated_duration_minutes"
        case specialInstructions = "special_instructions"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
