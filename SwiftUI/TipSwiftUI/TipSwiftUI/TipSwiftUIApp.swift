//
//  TipSwiftUIApp.swift
//  TipSwiftUI
//
//  Created by Steven Curtis on 26/04/2021.
//

import SwiftUI

@main
struct TipSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TipView(viewModel: TipViewModel())
        }
    }
}
