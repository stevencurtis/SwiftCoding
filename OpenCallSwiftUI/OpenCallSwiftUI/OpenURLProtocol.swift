//
//  OpenURLProtocol.swift
//  OpenCallSwiftUI
//
//  Created by Steven Curtis on 18/10/2023.
//

import UIKit

protocol OpenURLProtocol {
    func open(_ url: URL)
}

extension UIApplication: OpenURLProtocol {
    func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
