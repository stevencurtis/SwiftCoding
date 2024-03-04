import Combine
import Observation
import SwiftUI

@Observable
final class TermsViewModel {
    var termsConditions: [TermsConditions] = [
        TermsConditions(label: "Terms One", isChecked: false),
        TermsConditions(label: "Terms Two", isChecked: false),
    ] {
        didSet {
            buttonState = termsConditions.allSatisfy({ $0.isChecked }) ? .enabled : .disabled
        }
    }
    var buttonState: ButtonState = .disabled
    private var cancellables: Set<AnyCancellable> = []
}


struct TermsConditions: Identifiable {
    var id = UUID()
    
    let label: String
    var isChecked: Bool
}
