public enum UrgencyLevel: String, Codable, Hashable, Sendable, CaseIterable {
    case routine = "routine"
    case urgent = "urgent"
    case emergency = "emergency"
}
