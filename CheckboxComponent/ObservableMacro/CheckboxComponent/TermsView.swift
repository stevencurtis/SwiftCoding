import SwiftUI

struct TermsView: View {
    private var viewModel: TermsViewModel

    init(viewModel: TermsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        @Bindable(wrappedValue: viewModel) var viewModel: TermsViewModel
        VStack(alignment: .leading) {
            Text("Please carefully read and agree to the Terms and Conditions before proceeding")
            Divider()
            ForEach($viewModel.termsConditions) { $term in
                CheckboxView(isChecked: $term.isChecked, label: term.label)
            }
            Spacer()
            StatefulButtonView(buttonState: $viewModel.buttonState)
        }
        .padding()
    }
    
    struct CheckboxView: View {
        @Binding var isChecked: Bool
        let label: String
        var body: some View {
            HStack(alignment: .center) {
                Text(label)
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        isChecked.toggle()
                        print("Checkbox tapped, new state: \(isChecked)") 
                    }
            }
        }
    }
}

#Preview {
    TermsView(viewModel: TermsViewModel())
}
