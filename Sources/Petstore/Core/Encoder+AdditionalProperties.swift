extension Encoder {
    public func encodeAdditionalProperties<T: Encodable>(_ additionalProperties: [String: T]) throws
    {
        guard !additionalProperties.isEmpty else { return }
        var container = self.container(keyedBy: StringKey.self)
        for (key, value) in additionalProperties {
            try container.encode(value, forKey: StringKey(key))
        }
    }
}
