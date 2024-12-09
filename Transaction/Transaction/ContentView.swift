import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            AnimatedView(scale: scale)
                .onTapGesture {
                    var transaction = Transaction(animation: .linear)
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        scale += 0.1
                    }
                }
        }
    }
}

private struct AnimatedView: View {
    var scale: CGFloat
    
    var body: some View {
        Image(.rosa)
            .resizable()
            .scaledToFit()
            .frame(width: 100 * scale, height: 100 * scale)
            .animation(.bouncy(duration: 5.0), value: scale)
    }
}

#Preview {
    ContentView()
}
