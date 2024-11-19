import UIKit

enum Unauthenticated {}
enum Authenticated {}

struct APIRequest<State> {
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
}

extension APIRequest where State == Unauthenticated {
    func authenticate(with token: String) -> APIRequest<Authenticated> {
        APIRequest<Authenticated>(endpoint: endpoint)
    }
}

extension APIRequest where State == Authenticated {
    func send() {
        print("Sending authenticated request to \(endpoint)")
    }
}

let unauthenticatedRequest = APIRequest<Unauthenticated>(endpoint: "/user/profile")

// This will not compile:
// unauthenticatedRequest.send()

// Authenticate the request
let authenticatedRequest = unauthenticatedRequest.authenticate(with: "secureToken")

// Send the authenticated request
authenticatedRequest.send()
