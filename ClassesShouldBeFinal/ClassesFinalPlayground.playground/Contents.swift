import PlaygroundSupport
import UIKit

final class Animal {
    func makesNoise() {
        print("")
    }
}

class Dog: Animal {
    override func makesNoise() {
        print("barks")
    }
}

let lily = Dog()
lily.makesNoise()

final class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        self.view = view
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = MyViewController()
