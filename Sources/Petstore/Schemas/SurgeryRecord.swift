import Foundation

public struct SurgeryRecord: Codable, Hashable, Sendable {
    public let recordType: String = "surgery"
    public let id: Int64?
    public let petId: Int64
    public let veterinarianId: Int64
    public let createdAt: Date
    public let updatedAt: Date?
    public let urgencyLevel: UrgencyLevel?
    public let notes: String?
    public let procedureName: String
    public let surgeryDate: Date
    public let anesthesiaUsed: String?
    public let surgeryDurationMinutes: Int?
    public let recoveryNotes: String?
    public let postOpMedications: [String]?

    public init(
        id: Int64? = nil,
        petId: Int64,
        veterinarianId: Int64,
        createdAt: Date,
        updatedAt: Date? = nil,
        urgencyLevel: UrgencyLevel? = nil,
        notes: String? = nil,
        procedureName: String,
        surgeryDate: Date,
        anesthesiaUsed: String? = nil,
        surgeryDurationMinutes: Int? = nil,
        recoveryNotes: String? = nil,
        postOpMedications: [String]? = nil
    ) {
        self.id = id
        self.petId = petId
        self.veterinarianId = veterinarianId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.urgencyLevel = urgencyLevel
        self.notes = notes
        self.procedureName = procedureName
        self.surgeryDate = surgeryDate
        self.anesthesiaUsed = anesthesiaUsed
        self.surgeryDurationMinutes = surgeryDurationMinutes
        self.recoveryNotes = recoveryNotes
        self.postOpMedications = postOpMedications
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
        case procedureName = "procedure_name"
        case surgeryDate = "surgery_date"
        case anesthesiaUsed = "anesthesia_used"
        case surgeryDurationMinutes = "surgery_duration_minutes"
        case recoveryNotes = "recovery_notes"
        case postOpMedications = "post_op_medications"
    }
}
