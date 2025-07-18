public struct Pet: Codable, Hashable, Sendable {
    public let id: Int?
    public let name: String
    public let category: Category?
    public let photoUrls: [String]
    public let tags: [Tag]?
    /// pet status in the store
    public let status: Status?

    /// pet status in the store
    public enum Status: String, Codable, Hashable, CaseIterable, Sendable {
        case available = "available"
        case pending = "pending"
        case sold = "sold"
    }

    public init(
        id: Int? = nil,
        name: String,
        category: Category? = nil,
        photoUrls: [String],
        tags: [Tag]? = nil,
        status: Status? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.photoUrls = photoUrls
        self.tags = tags
        self.status = status
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case photoUrls
        case tags
        case status
    }
}
