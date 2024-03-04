import SwiftUI

struct StatefulButtonView: View {
    @Binding var buttonState: ButtonState

    var body: some View {
        Button(action: {
            print("SwiftUI button clicked")
        }) {
            ZStack {
                if buttonState == .loading {
                    HStack(spacing: 0) {
                        ActivityIndicator(
                            isAnimating: .constant(true),
                            style: .medium
                        )
                            .padding(.leading, 16)
                        Spacer()
                    }
                }
                HStack(spacing: 0) {
                    Spacer()
                    Text(buttonTitle)
                    Spacer()
                }
            }
            .foregroundColor(buttonTitleColor)
            .frame(maxWidth: .infinity, minHeight: 34.5)
            .background(buttonBackgroundColor)
            .cornerRadius(15)
        }
        .disabled(buttonState == .disabled)
    }

    var buttonTitle: String {
        switch buttonState {
        case .enabled:
            return DesignConfig.shared.enabledConfig.title
        case .loading:
            return DesignConfig.shared.loadingConfig.title
        case .selected:
            return DesignConfig.shared.selectedConfig.title
        case .disabled:
            return DesignConfig.shared.disabledConfig.title
        }
    }

    var buttonBackgroundColor: Color {
        switch buttonState {
        case .enabled:
            return DesignConfig.shared.enabledConfig.backgroundColor.swiftUIColor
        case .loading:
            return DesignConfig.shared.loadingConfig.backgroundColor.swiftUIColor
        case .selected:
            return DesignConfig.shared.selectedConfig.backgroundColor.swiftUIColor
        case .disabled:
            return DesignConfig.shared.disabledConfig.backgroundColor.swiftUIColor
        }
    }

    var buttonTitleColor: Color {
        switch buttonState {
        case .enabled:
            return DesignConfig.shared.enabledConfig.titleColor.swiftUIColor
        case .loading: 
            return DesignConfig.shared.loadingConfig.titleColor.swiftUIColor
        case .selected: 
            return DesignConfig.shared.selectedConfig.titleColor.swiftUIColor
        case .disabled:
            return DesignConfig.shared.disabledConfig.titleColor.swiftUIColor
        }
    }
}

#Preview {
    Group {
        StatefulButtonView(buttonState: .constant(.enabled))
        StatefulButtonView(buttonState: .constant(.selected))
        StatefulButtonView(buttonState: .constant(.loading))
        StatefulButtonView(buttonState: .constant(.disabled))
    }
}
