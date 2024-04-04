import SwiftUI

struct ImageSequenceContentView: View {
    var images: [String] = []

    init(imagePrefix: String = "number_") {
        for i in 0..<10 {
            let imageName = "\(imagePrefix)\(i)"
            images.append(imageName)
        }
    }
    var body: some View {
        VStack {
            AnimatedImageView(
                duration: 2.0,
                imageNames: images,
                animating: .constant(
                    true
                )
            )
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ImageSequenceContentView()
}
