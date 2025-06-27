import Foundation

struct FindPetsByStatus {
    struct QueryParams: Sendable, QueryParameterConvertible {
        let status: String?
        let limit: Int?
        let offset: Int?

        init(status: String? = nil, limit: Int? = nil, offset: Int? = nil) {
            self.status = status
            self.limit = limit
            self.offset = offset
        }
    }
}

struct FindPetsByTags {
    struct QueryParams: Sendable, QueryParameterConvertible {
        let tags: [String]?

        init(tags: [String]? = nil) {
            self.tags = tags
        }
    }
}

struct UpdatePetWithForm {
    struct QueryParams: Sendable, QueryParameterConvertible {
        let name: String?
        let status: String?

        init(name: String? = nil, status: String? = nil) {
            self.name = name
            self.status = status
        }
    }
}

struct UploadFile {
    struct QueryParams: Sendable, QueryParameterConvertible {
        let additionalMetadata: String?

        init(additionalMetadata: String? = nil) {
            self.additionalMetadata = additionalMetadata
        }
    }
}

struct LoginUser {
    struct QueryParams: Sendable, QueryParameterConvertible {
        let username: String?
        let password: String?

        init(username: String? = nil, password: String? = nil) {
            self.username = username
            self.password = password
        }
    }
}
