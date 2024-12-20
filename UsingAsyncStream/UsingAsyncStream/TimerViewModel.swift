import Observation

@Observable
final class TimerViewModel {
    private(set) var time: String = "default"
    private let timerService: TimerServiceProtocol
    init(timerService: TimerServiceProtocol = TimerService()) {
        self.timerService = timerService
    }

    func initializer() async {
        for await newTime in timerService.timeStream() {
            time = newTime
        }
    }
}
