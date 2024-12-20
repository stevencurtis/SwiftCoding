import Foundation

protocol TimerServiceProtocol {
    func timeStream() -> AsyncStream<String>
}

final class TimerService: TimerServiceProtocol {
    private let date: () -> Date
    private let formatter: DateFormatter
    private let interval: TimeInterval

    init(
        formatter: DateFormatter = TimerService.defaultFormatter(),
        interval: TimeInterval = 1.0,
        currentDate: @escaping @autoclosure () -> Date = Date()
    ) {
        self.date = currentDate
        self.formatter = formatter
        self.interval = interval
    }

    func timeStream() -> AsyncStream<String> {
        return AsyncStream { continuation in
            let now = dispatchTime(from: date())
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: now, repeating: interval)
            timer.setEventHandler { [weak self] in
                guard let self else { return }
                let date = date()
                let currentTime = self.formatter.string(from: date)
                continuation.yield(currentTime)
            }
            timer.resume()

            continuation.onTermination = { _ in
                timer.cancel()
            }
        }
    }

    private func dispatchTime(from date: Date) -> DispatchTime {
        let timeInterval = date.timeIntervalSinceNow
        return DispatchTime.now() + timeInterval
    }
    
    private static func defaultFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
}
