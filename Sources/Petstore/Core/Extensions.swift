private struct StringKey: CodingKey, Hashable {
    var stringValue: String
    var intValue: Int? { Int(stringValue) }

    init(_ string: String) { self.stringValue = string }

    init?(stringValue: String) { self.stringValue = stringValue }

    init?(intValue: Int) { self.stringValue = String(intValue) }
}

extension Decoder {
    public func decodeAdditionalProperties<T: Decodable>(knownKeys: Set<String>) throws -> [String:
        T]
    {
        let container = try container(keyedBy: StringKey.self)
        let unknownKeys = Set(container.allKeys).subtracting(knownKeys.map(StringKey.init(_:)))
        guard !unknownKeys.isEmpty else { return .init() }
        let keyValuePairs: [(String, T)] = try unknownKeys.compactMap { key in
            (key.stringValue, try container.decode(T.self, forKey: key))
        }
        return .init(uniqueKeysWithValues: keyValuePairs)
    }
}
