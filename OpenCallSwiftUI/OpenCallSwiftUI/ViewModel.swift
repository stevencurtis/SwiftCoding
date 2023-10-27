//
//  ViewModel.swift
//  OpenCallSwiftUI
//
//  Created by Steven Curtis on 18/10/2023.
//

import UIKit

final class ViewModel: ObservableObject {
    let openURL: OpenURLProtocol
    init(openURL: OpenURLProtocol = UIApplication.shared) {
        self.openURL = openURL
    }
    func callNumber() {
        guard let url = URL(string: "tel://08000480408") else { return }
        openURL.open(url)
    }
}
