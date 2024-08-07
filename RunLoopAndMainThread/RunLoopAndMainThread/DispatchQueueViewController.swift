import Combine
import UIKit

final class DispatchQueueViewController: UIViewController {
    var cancellable: AnyCancellable?
    let publisher = PassthroughSubject<String, Never>()
    @IBOutlet private weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Using DispatchQueue.main for immediate updates
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.updateUI(with: value)
            }
        
        // Simulating a value being published
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.publisher.send("Updates even when you scroll")
        }
    }
    
    
    func updateUI(with value: String) {
        // Update your UI here
        label.text = value
        print("Received value on main thread: \(value)")
    }
}
