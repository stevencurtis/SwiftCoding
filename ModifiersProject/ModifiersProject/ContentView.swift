import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, SwiftUI!")
                .font(.title)
                .foregroundColor(.blue)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .opacity(0.5)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            Text("Hello, SwiftUI!")
                .onTapGesture {
                    print("Tapped")
                }
            Text("Card Text")
                .modifier(CardModifier())
            Text("Text with Card Style")
                .cardStyle()
            
            Text("Customizable Card")
                .customCardStyle(backgroundColor: .blue, cornerRadius: 20)
        }
        .padding()
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

struct CustomCardModifier: ViewModifier {
    var backgroundColor: Color
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func customCardStyle(backgroundColor: Color = .white, cornerRadius: CGFloat = 10) -> some View {
        self.modifier(CustomCardModifier(backgroundColor: backgroundColor, cornerRadius: cornerRadius))
    }
}


#Preview {
    ContentView()
}
