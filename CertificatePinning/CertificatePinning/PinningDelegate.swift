import Foundation

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
        
        var serverCertificates: [SecCertificate] = []
        if let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] {
            serverCertificates = certificateChain
        }
        
        guard let serverCertificate = serverCertificates.first else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
        
        if pinnedCertificate == serverCertificateData {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
