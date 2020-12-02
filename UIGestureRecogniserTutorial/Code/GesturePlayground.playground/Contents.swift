import UIKit

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    
    let clickableView = UIView()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .lightGray
                
        clickableView.backgroundColor = .blue
        
        view.addSubview(clickableView)

        clickableView.translatesAutoresizingMaskIntoConstraints = false
        clickableView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        clickableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        clickableView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        clickableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        clickableView.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        clickableView.addGestureRecognizer(pinch)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        clickableView.addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLP(_:)))
        longPress.minimumPressDuration = 0.5
        clickableView.addGestureRecognizer(longPress)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotateGesture))
        clickableView.addGestureRecognizer(rotate)
    }
    
    @objc func handleRotateGesture(_ sender: UIRotationGestureRecognizer) {
        guard sender.view != nil else { return }
             
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = sender.view!.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        guard let pressedView = sender.view else {
            return
        }
        print ("The \(pressedView.description) view has been long pressed")
    }
    
    @objc func handleLP(_ sender: UILongPressGestureRecognizer) {
        guard let pressedView = sender.view else {
            return
        }
        print ("The \(pressedView.description) view has been long pressed")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else {
            return
        }
        print ("The \(tappedView.description) view has been tapped!")
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let gestureView = sender.view else {
          return
        }
        // implement the transformation, scaled by the space between fingers
        gestureView.transform = gestureView.transform.scaledBy(
          x: sender.scale,
          y: sender.scale
        )
        // set the scale to be 1
        sender.scale = 1
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view else {return}
        let translation = sender.translation(in: view)
        targetView.center = CGPoint(x: targetView.center.x + translation.x
            ,y: targetView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
}

PlaygroundPage.current.liveView = MyViewController()
