import UIKit
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    let strings = ["1", "2", "3", "4", "5"]

    var body: some View {
        List(strings, id: \.self) { string in
            Text(string)
        }
    }
}

let viewController = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

