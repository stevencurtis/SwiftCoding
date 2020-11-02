import UIKit
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
    }
}

let viewController = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
