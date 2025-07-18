public enum ContactMethod: String, Codable, Hashable, CaseIterable, Sendable {
    case phone = "phone"
    case email = "email"
    case both = "both"
}
