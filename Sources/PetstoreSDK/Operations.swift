import Foundation

public struct FindPetsByStatus {
    public struct QueryParams: Sendable, QueryParameterConvertible {
        public let status: String?
        public let limit: Int?
        public let offset: Int?

        public init(status: String? = nil, limit: Int? = nil, offset: Int? = nil) {
            self.status = status
            self.limit = limit
            self.offset = offset
        }
    }
}

public struct UploadFile {
    public struct QueryParams: Sendable, QueryParameterConvertible {
        public let additionalMetadata: String?

        public init(additionalMetadata: String? = nil) {
            self.additionalMetadata = additionalMetadata
        }
    }
}

public struct LoginUser {
    public struct QueryParams: Sendable, QueryParameterConvertible {
        public let username: String?
        public let password: String?

        public init(username: String? = nil, password: String? = nil) {
            self.username = username
            self.password = password
        }
    }
}
