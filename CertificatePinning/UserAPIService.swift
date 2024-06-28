import NetworkClient
import Foundation

protocol ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO]
}

final class ListAPIService {
    private let networkClient: NetworkClient
    init(
//        networkClient: NetworkClient = MainNetworkClient()
    ) {
        let session = URLSession(configuration: .default, delegate: PinningDelegate(), delegateQueue: nil)
        networkClient = MainNetworkClient(urlSession: session)
//        self.networkClient = networkClient
    }
}

extension ListAPIService: ListAPIServiceProtocol {
    func getUsers() async throws -> [UserDTO] {
        let userRequest = UserRequest()
        let api = API.users
        let users = try await APIService().performRequest(
            api: api,
            request: userRequest,
            networkClient: networkClient
        )
        return users
    }
}

final class PinningDelegate: NSObject, URLSessionDelegate {
    private func getPinnedCertificate() -> Data? {
        guard let certPath = Bundle.main.path(forResource: "certificate", ofType: "der") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: certPath))
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust,
              SecTrustGetCertificateCount(serverTrust) > 0,
              let pinnedCertificate = getPinnedCertificate() else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Compare server certificate with pinned certificate
        let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
        let serverCertificateData = SecCertificateCopyData(serverCertificate!) as Data
        
        // Debugging: Print certificates in base64 encoding for comparison
        print("Pinned Certificate:\n\(pinnedCertificate.base64EncodedString())")
        print("Server Certificate:\n\(serverCertificateData.base64EncodedString())")
              
        if pinnedCertificate == serverCertificateData {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
