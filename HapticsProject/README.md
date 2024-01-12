# Haptics in UIKit: A Simple Guide
## Appear that section!

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

The background to this is that some time ago I needed to implement Haptics. Looking at the files, this was in 2021. It's probably time I shared my simple guide how to use `UINotificationFeedbackGenerator` and `UISelectionFeedbackGenerator`.

# Using Haptics
Sure, you can use the [documentation](https://developer.apple.com/documentation/uikit/uinotificationfeedbackgenerator) but I like to have a simple project to see how this could be used. Basically I just wanted a view that would cycle through a load of haptics feedback.

## The Code
This is the code for haptics. Nothing too special here, although the implementation is in code only. I've used a switch statement so there is only a single haptic at any one time. On with the code!

```swift
import UIKit

final class ViewController: UIViewController {
    var i = 0
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 128).isActive = true
        button.heightAnchor.constraint(equalToConstant: 128).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.setTitle("Tap here!", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        i += 1
        print("Running \(i)")
        
        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
}
```

# Conclusion
If you've got any comments I'd love to hear them. Anyway this is how I might implement a component library and I hope you enjoyed reading this.
