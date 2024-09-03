
import SwiftUI

struct BasicView: View {
    var body: some View {
        ScrollViewReader { proxy in
            Button("Scroll to item 25") {
                withAnimation {
                    proxy.scrollTo(25, anchor: .center)
                }
            }
            ScrollView {
                VStack {
                    ForEach(0..<50, id: \.self) { index in
                        Text("Item \(index)")
                            .id(index)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .padding(.vertical, 2)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    BasicView()
}
