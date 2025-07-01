import Foundation

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
        emergencyContactAvailable: Bool? = nil
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
