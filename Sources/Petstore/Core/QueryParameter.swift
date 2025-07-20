enum QueryParameter {
    case string(String)
    case optionalString(String?)
    case stringArray([String])
    case optionalStringArray([String]?)
    case int(Int)
    case optionalInt(Int?)

    func toString() -> String? {
        switch self {
        case .string(let value):
            return value
        case .optionalString(let value):
            return value
        case .stringArray(let values):
            return values.joined(separator: ",")
        case .optionalStringArray(let values):
            return values?.joined(separator: ",")
        case .int(let value):
            return String(value)
        case .optionalInt(let value):
            return value.map(String.init)
        }
    }
}
