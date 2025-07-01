public enum UrgencyLevel: Int, Codable, Hashable, Sendable, CaseIterable {
    case routine = 1
    case urgent = 2
    case emergency = 3
}
