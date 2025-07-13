public enum MedicalRecord: Codable, Hashable, Sendable {
    case vaccination(VaccinationRecord)
    case checkup(CheckupRecord)
    case surgery(SurgeryRecord)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recordType = try container.decode(String.self, forKey: .recordType)
        switch recordType {
        case "vaccination":
            self = .vaccination(try VaccinationRecord(from: decoder))
        case "checkup":
            self = .checkup(try CheckupRecord(from: decoder))
        case "surgery":
            self = .surgery(try SurgeryRecord(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown record type: \(recordType)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .vaccination(let data):
            try data.encode(to: encoder)
        case .checkup(let data):
            try data.encode(to: encoder)
        case .surgery(let data):
            try data.encode(to: encoder)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case recordType = "record_type"
    }
}
