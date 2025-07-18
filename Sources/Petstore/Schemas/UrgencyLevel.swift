public enum UrgencyLevel: Int, Codable, Hashable, CaseIterable, Sendable {
    case routine = 1
    case urgent = 2
    case emergency = 3
}
