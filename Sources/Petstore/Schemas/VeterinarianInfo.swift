public struct VeterinarianInfo: Codable, Hashable, Sendable {
    public let id: Int64
    public let firstName: String
    public let lastName: String
    public let licenseNumber: String
    public let specialization: String?
    public let yearsExperience: Int?
    public let clinicName: String?
    public let contactMethod: ContactMethod?
    public let phoneNumber: String?
    public let emailAddress: String?
    public let emergencyContactAvailable: Bool?
    public let additionalProperties: [String: String]

    public init(
        id: Int64,
        firstName: String,
        lastName: String,
        licenseNumber: String,
        specialization: String? = nil,
        yearsExperience: Int? = nil,
        clinicName: String? = nil,
        contactMethod: ContactMethod? = nil,
        phoneNumber: String? = nil,
        emailAddress: String? = nil,
        emergencyContactAvailable: Bool? = nil,
        additionalProperties: [String: String] = .init()
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.licenseNumber = licenseNumber
        self.specialization = specialization
        self.yearsExperience = yearsExperience
        self.clinicName = clinicName
        self.contactMethod = contactMethod
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.emergencyContactAvailable = emergencyContactAvailable
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.licenseNumber = try container.decode(String.self, forKey: .licenseNumber)
        self.specialization = try container.decodeIfPresent(String.self, forKey: .specialization)
        self.yearsExperience = try container.decodeIfPresent(Int.self, forKey: .yearsExperience)
        self.clinicName = try container.decodeIfPresent(String.self, forKey: .clinicName)
        self.contactMethod = try container.decodeIfPresent(
            ContactMethod.self, forKey: .contactMethod)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
        self.emergencyContactAvailable = try container.decodeIfPresent(
            Bool.self, forKey: .emergencyContactAvailable)
        self.additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [
            "id",
            "first_name",
            "last_name",
            "license_number",
            "specialization",
            "years_experience",
            "clinic_name",
            "contact_method",
            "phone_number",
            "email_address",
            "emergency_contact_available",
        ])
    }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case licenseNumber = "license_number"
        case specialization
        case yearsExperience = "years_experience"
        case clinicName = "clinic_name"
        case contactMethod = "contact_method"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case emergencyContactAvailable = "emergency_contact_available"
    }
}
