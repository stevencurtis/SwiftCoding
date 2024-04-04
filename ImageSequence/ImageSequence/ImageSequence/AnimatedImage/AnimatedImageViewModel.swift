import Foundation

final class AnimatedImageViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    private var timer: TimerProtocol?
    private let imageCount: Int
    private let interval: TimeInterval
    private let repeats: Bool
    private let timerFactory: TimerFactoryProtocol
    
    init(
        interval: TimeInterval,
        imageCount: Int,
        repeats: Bool,
        timerFactory: TimerFactoryProtocol = TimerFactory()
    ) {
        self.interval = interval
        self.imageCount = imageCount
        self.repeats = repeats
        self.timerFactory = timerFactory
    }
    
    func start() {
        guard timer == nil else { return }
        timer = timerFactory.createTimer(withTimeInterval: interval, repeats: repeats) { [weak self] _ in
            guard let self else { return }
            currentIndex = (currentIndex + 1) % imageCount
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
