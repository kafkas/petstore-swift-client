public struct Medication: Codable, Hashable, Sendable {
    public let medicationName: String
    public let dosage: String
    public let frequency: String
    public let administrationMethod: String?
    public let specialInstructions: String?

    public init(
        medicationName: String,
        dosage: String,
        frequency: String,
        administrationMethod: String? = nil,
        specialInstructions: String? = nil
    ) {
        self.medicationName = medicationName
        self.dosage = dosage
        self.frequency = frequency
        self.administrationMethod = administrationMethod
        self.specialInstructions = specialInstructions
    }

    enum CodingKeys: String, CodingKey {
        case medicationName = "medication_name"
        case dosage
        case frequency
        case administrationMethod = "administration_method"
        case specialInstructions = "special_instructions"
    }
}
