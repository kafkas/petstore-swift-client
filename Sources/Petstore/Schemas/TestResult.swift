public enum TestResult: Codable, Hashable, Sendable {
    case string(String)
    case number(Double)
    case boolean(Bool)
}
