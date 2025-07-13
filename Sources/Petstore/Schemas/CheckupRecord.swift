public struct CheckupRecord: Codable, Hashable, Sendable {
    public let recordType: String = "checkup"
    public let id: Int64?
    public let petId: Int64
    public let veterinarianId: Int64
    public let createdAt: Date
    public let updatedAt: Date?
    public let urgencyLevel: UrgencyLevel?
    public let notes: String?
    public let weightKg: Double?
    public let temperatureCelsius: Double?
    public let heartRateBpm: Int?
    public let followUpRequired: Bool
    public let examinationFindings: String?
    public let primaryTestResult: TestResult?

    public init(
        id: Int64? = nil,
        petId: Int64,
        veterinarianId: Int64,
        createdAt: Date,
        updatedAt: Date? = nil,
        urgencyLevel: UrgencyLevel? = nil,
        notes: String? = nil,
        weightKg: Double? = nil,
        temperatureCelsius: Double? = nil,
        heartRateBpm: Int? = nil,
        followUpRequired: Bool,
        examinationFindings: String? = nil,
        primaryTestResult: TestResult? = nil
    ) {
        self.id = id
        self.petId = petId
        self.veterinarianId = veterinarianId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.urgencyLevel = urgencyLevel
        self.notes = notes
        self.weightKg = weightKg
        self.temperatureCelsius = temperatureCelsius
        self.heartRateBpm = heartRateBpm
        self.followUpRequired = followUpRequired
        self.examinationFindings = examinationFindings
        self.primaryTestResult = primaryTestResult
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
        case weightKg = "weight_kg"
        case temperatureCelsius = "temperature_celsius"
        case heartRateBpm = "heart_rate_bpm"
        case followUpRequired = "follow_up_required"
        case examinationFindings = "examination_findings"
        case primaryTestResult = "primary_test_result"
    }
}
