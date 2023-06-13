//
//  DocumentGroup.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

// @main
private struct WhatsNew2023: App {
    var body: some Scene {
        DocumentGroup(editing: DogTag.self, contentType: .dogTag) {
            ContentView()
        }
    }
    
    struct ContentView: View {
        var body: some View {
            Color.clear
        }
    }

    @Model
    class DogTag {
        var text = ""
    }
}

extension UTType {
    static var dogTag: UTType {
        UTType(exportedAs: "com.apple.SwiftUI.dogTag")
    }
}
