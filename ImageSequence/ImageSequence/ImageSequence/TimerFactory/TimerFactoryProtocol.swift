import Foundation

public protocol TimerFactoryProtocol {
    func createTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping @Sendable (TimerProtocol) -> Void) -> TimerProtocol
}
