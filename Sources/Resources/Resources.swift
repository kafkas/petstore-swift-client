struct Category: Codable, Hashable, Sendable {
    let id: Int?
    let name: String?
}

struct Tag: Codable, Hashable, Sendable {
    let id: Int?
    let name: String?
}

struct Pet: Codable, Hashable, Sendable {
    let id: Int?
    let name: String
    let category: Category?
    let photoUrls: [String]
    let tags: [Tag]?
    let status: Status?

    enum Status: String, Codable, Hashable, Sendable, CaseIterable {
        case available = "available"
        case pending = "pending"
        case sold = "sold"
    }

    init(
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
