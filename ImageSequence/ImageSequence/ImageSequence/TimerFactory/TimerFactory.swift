import Foundation

public final class TimerFactory: TimerFactoryProtocol {
    public func createTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping @Sendable (TimerProtocol) -> Void) -> TimerProtocol {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) {
            block($0 as TimerProtocol)
        }
    }
    
    public init() {}
}
