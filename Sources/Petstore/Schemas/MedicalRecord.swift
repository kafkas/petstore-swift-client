import Foundation

public enum MedicalRecord: Codable, Hashable, Sendable {
    case vaccination(VaccinationRecord)
    case checkup(CheckupRecord)
    case surgery(SurgeryRecord)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recordType = try container.decode(String.self, forKey: .recordType)

        switch recordType {
        case "vaccination":
            let record = try VaccinationRecord.init(from: decoder)
            self = .vaccination(record)
        case "checkup":
            let record = try CheckupRecord.init(from: decoder)
            self = .checkup(record)
        case "surgery":
            let record = try SurgeryRecord.init(from: decoder)
            self = .surgery(record)
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
        case .vaccination(let record):
            try record.encode(to: encoder)
        case .checkup(let record):
            try record.encode(to: encoder)
        case .surgery(let record):
            try record.encode(to: encoder)
        }
    }

    enum CodingKeys: String, CodingKey {
        case recordType = "record_type"
    }
}
