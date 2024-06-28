import Foundation
import NetworkClient

enum API: URLGenerator {
    case users

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = path
        return components.url
    }
    
    var method: HTTPMethod {
        return .get()
    }

}

extension API {
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
}
