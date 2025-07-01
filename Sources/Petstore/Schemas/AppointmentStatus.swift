public enum AppointmentStatus: String, Codable, Hashable, Sendable, CaseIterable {
    case scheduled = "scheduled"
    case confirmed = "confirmed"
    case inProgress = "in_progress"
    case completed = "completed"
    case cancelled = "cancelled"
    case noShow = "no_show"
}
