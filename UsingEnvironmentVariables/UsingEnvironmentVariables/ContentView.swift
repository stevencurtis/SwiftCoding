import SwiftUI

extension EnvironmentValues {
    @Entry var iconColor: Color = .red
}

struct StarsView: View {
    @Environment(\.iconColor) var iconColor

    var body: some View {
        Image(systemName: "star.fill")
            .foregroundStyle(iconColor)
            .font(.largeTitle)
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .foregroundColor(colorScheme == .dark ? .pink : .black)
            HStack {
                StarsView()
                StarsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.iconColor, .red)
        .environment(\.colorScheme, .dark)
    
}

#Preview {
    ContentView()
        .environment(\.iconColor, .blue)
        .environment(\.colorScheme, .light)
}
