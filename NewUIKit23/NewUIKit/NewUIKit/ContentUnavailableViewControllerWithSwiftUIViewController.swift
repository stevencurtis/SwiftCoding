//
//  ContentUnavailableViewControllerWithSwiftUIViewController.swift
//  NewUIKit
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI
import UIKit

class ContentUnavailableViewControllerWithSwiftUIViewController: UIViewController {
    @State private var progress = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = UIHostingConfiguration {
            VStack {
                ProgressView(value: progress)
                Text("Downloading file...")
                    .foregroundStyle(.secondary)
            }
        }
        contentUnavailableConfiguration = config
    }
}
