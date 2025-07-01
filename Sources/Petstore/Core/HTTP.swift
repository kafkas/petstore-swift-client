import Foundation

struct HTTP {
    enum Method: String, CaseIterable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum ContentType: String, CaseIterable {
        case applicationJson = "application/json"
        case applicationOctetStream = "application/octet-stream"
    }

    enum RequestBody {
        // TODO: Rename to json-encodable
        case encodable(any Encodable)
        case data(Data)
    }
}
