enum QueryParameter {
    case string(String)
    case int(Int)
    case stringArray([String])
    case uuid(UUID)

    func toString() -> String {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return String(value)
        case .stringArray(let values):
            return values.joined(separator: ",")
        case .uuid(let value):
            return value.uuidString
        }
    }
}
