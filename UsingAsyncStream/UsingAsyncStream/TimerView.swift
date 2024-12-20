import SwiftUI

struct TimerView: View {
    var timerViewModel: TimerViewModel
    var body: some View {
        VStack {
            Text("Current time: \(timerViewModel.time)")
        }
        .padding()
        .task {
            await timerViewModel.initializer()
        }
    }
}

#Preview {
    TimerView(timerViewModel: TimerViewModel())
}
