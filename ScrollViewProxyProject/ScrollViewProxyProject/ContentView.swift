import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo("bottomID")
                    }
                }
                .id("topID") // Assigning the top button an ID

                VStack(spacing: 0) {
                    ForEach(0..<100, id: \.self) { i in
                        color(fraction: Double(i) / 100)
                            .frame(height: 32)
                    }
                }

                Button("Scroll to Top") {
                    withAnimation {
                        proxy.scrollTo("topID")
                    }
                }
                .id("bottomID") // Assigning the bottom button an ID
            }
        }
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

#Preview {
    ContentView()
}
