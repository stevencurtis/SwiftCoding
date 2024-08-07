import Combine
import UIKit

final class RunLoopMainViewController: UIViewController {
    var cancellable: AnyCancellable?
    let publisher = PassthroughSubject<String, Never>()
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Using RunLoop.main for updates that wait until other touches are finished
        cancellable = publisher
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.updateUI(with: value)
            }
        
        // Simulating a value being published
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.publisher.send("Waits until you have finished scrolling")
        }
    }
    
    func updateUI(with value: String) {
        // Update your UI here
        label.text = value
        print("Received value on main thread: \(value)")
    }
}
