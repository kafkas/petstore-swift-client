import Foundation

protocol QueryParameterConvertible {
    func toDictionary() -> [String: String]
}

extension QueryParameterConvertible {
    public func toDictionary() -> [String: String] {
        let mirror = Mirror(reflecting: self)
        var dict: [String: String] = [:]

        for child in mirror.children {
            guard let propertyName = child.label else { continue }

            switch child.value {
            case let optionalValue as (any OptionalType):
                if let unwrappedValue = optionalValue.wrappedValue {
                    dict[propertyName] = String(describing: unwrappedValue)
                }
            case let value:
                dict[propertyName] = String(describing: value)
            }
        }

        return dict
    }
}

// Helper protocol to handle optionals generically
private protocol OptionalType {
    var wrappedValue: Any? { get }
}

extension Optional: OptionalType {
    var wrappedValue: Any? {
        switch self {
        case .some(let value):
            return value
        case .none:
            return nil
        }
    }
}
