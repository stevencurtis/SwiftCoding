import Foundation
import PlaygroundSupport

class Poller {
    private var timer: Timer?
    private var stop: (() -> Bool)?
    func startPolling(stop: @escaping () -> Bool) {
        self.stop = stop
        timer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
        guard let timer = self.timer else { return }

        RunLoop.main.add(timer, forMode: RunLoop.Mode.default)
    }
    
    @objc private func fireTimer() {
        print("Make API call")
        if stop?() == true {
            timer?.invalidate()
        }
    }
    
    func stopPolling() {
        timer?.invalidate()
    }
}
let end = Date() + 6
let poller = Poller()
poller.startPolling() { Date() >= end }

PlaygroundPage.current.needsIndefiniteExecution = true
