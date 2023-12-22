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
    func email() {
        guard let url = URL(string: "mailto:support@example.com") else { return }
        openURL.open(url)
    }
    
    func emailWithSubject() {
        let subject = "Feedback"
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)") else { return }
        openURL.open(url)
    }
    
    func emailWithSubjectAndBody() {
        let subject = "Feedback"
        let body = "I wanted to share some feedback about...'the issue' ok"

        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "mailto:support@example.com?subject=\(encodedSubject)&body=\(encodedBody)") {
            openURL.open(url)
        }
    }
}
