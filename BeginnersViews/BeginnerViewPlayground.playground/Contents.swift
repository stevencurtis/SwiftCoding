import PlaygroundSupport
import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)

            Button("Increment") {
                count += 1
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

let host = UIHostingController(rootView: CounterView())
host.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

PlaygroundPage.current.liveView = host

