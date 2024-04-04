import SwiftUI

public struct AnimatedImageView: View {
    @Binding var animating: Bool
    @StateObject private var viewModel: AnimatedImageViewModel
    private let imageNames: [String]
    init(
        duration: TimeInterval,
        imageNames: [String],
        repeats: Bool = true,
        animating: Binding<Bool>
    ) {
        self.imageNames = imageNames
        _viewModel = StateObject(
            wrappedValue: AnimatedImageViewModel(
                interval: duration / Double(
                    imageNames.count
                ),
                imageCount: imageNames.count,
                repeats: repeats
            )
        )
        _animating = animating
    }
    
    public var body: some View {
        Image(imageNames[viewModel.currentIndex])
            .onChange(of: animating) {
                if animating {
                    viewModel.start()
                } else {
                    viewModel.stop()
                }
            }
            .onAppear {
                if animating {
                    viewModel.start()
                }
            }
    }
}
