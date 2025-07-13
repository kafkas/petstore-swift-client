struct FindPetsByStatus {
    struct QueryParams: Sendable, QueryParameterConvertible {
        /// Status values that need to be considered for filter
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
        /// Tags to filter by
        let tags: [String]?

        init(tags: [String]? = nil) {
            self.tags = tags
        }
    }
}

struct UpdatePetWithForm {
    struct QueryParams: Sendable, QueryParameterConvertible {
        /// Name of pet that needs to be updated
        let name: String?
        /// Status of pet that needs to be updated
        let status: String?

        init(name: String? = nil, status: String? = nil) {
            self.name = name
            self.status = status
        }
    }
}

struct UploadFile {
    struct QueryParams: Sendable, QueryParameterConvertible {
        /// Additional Metadata
        let additionalMetadata: String?

        init(additionalMetadata: String? = nil) {
            self.additionalMetadata = additionalMetadata
        }
    }
}

struct LoginUser {
    struct QueryParams: Sendable, QueryParameterConvertible {
        /// The user name for login
        let username: String?
        /// The password for login in clear text
        let password: String?

        init(username: String? = nil, password: String? = nil) {
            self.username = username
            self.password = password
        }
    }
}
