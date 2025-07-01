public enum ContactMethod: String, Codable, Hashable, Sendable, CaseIterable {
    case phone = "phone"
    case email = "email"
    case both = "both"
}
