import UIKit

class SubclassedView: UIView {
    var closure: ((String) -> Void)?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        isUserInteractionEnabled = true
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let frame = self.bounds.insetBy(dx: -20, dy: -20)
        if frame.contains(point) {
            closure?("\(point)")
        }
        return nil
    }
}
