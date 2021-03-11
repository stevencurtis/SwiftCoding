//
//  Certificates.swift
//  SSLPinningExample
//
//  Created by Steven Curtis on 28/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

struct Certificates {
    static let pwned =
        Certificates.certificate(filename: "haveibeenpwned.com")
    
    private static func certificate(filename: String) -> SecCertificate {
        let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(nil, data as CFData)!
        
        return certificate
    }
}
