import Foundation

public struct TreatmentRecord: Codable, Hashable, Sendable {
    public let id: Int64?
    public let recordType: String = "treatment"
    public let petId: Int64
    public let veterinarianId: Int64
    public let createdAt: Date
    public let updatedAt: Date?
    public let urgencyLevel: UrgencyLevel?
    public let notes: String?

    // Treatment-specific fields
    public let conditionDiagnosed: String
    public let treatmentPlan: String
    public let medicationsPrescribed: [Medication]?
    public let treatmentStartDate: Date?
    public let treatmentEndDate: Date?

    public init(
        id: Int64? = nil,
        petId: Int64,
        veterinarianId: Int64,
        createdAt: Date,
        updatedAt: Date? = nil,
        urgencyLevel: UrgencyLevel? = nil,
        notes: String? = nil,
        conditionDiagnosed: String,
        treatmentPlan: String,
        medicationsPrescribed: [Medication]? = nil,
        treatmentStartDate: Date? = nil,
        treatmentEndDate: Date? = nil
    ) {
        self.id = id
        self.petId = petId
        self.veterinarianId = veterinarianId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.urgencyLevel = urgencyLevel
        self.notes = notes
        self.conditionDiagnosed = conditionDiagnosed
        self.treatmentPlan = treatmentPlan
        self.medicationsPrescribed = medicationsPrescribed
        self.treatmentStartDate = treatmentStartDate
        self.treatmentEndDate = treatmentEndDate
    }

    enum CodingKeys: String, CodingKey {
        case id
        case recordType = "record_type"
        case petId = "pet_id"
        case veterinarianId = "veterinarian_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case urgencyLevel = "urgency_level"
        case notes
        case conditionDiagnosed = "condition_diagnosed"
        case treatmentPlan = "treatment_plan"
        case medicationsPrescribed = "medications_prescribed"
        case treatmentStartDate = "treatment_start_date"
        case treatmentEndDate = "treatment_end_date"
    }
}
