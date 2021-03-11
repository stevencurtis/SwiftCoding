

// dragging(gesture
@objc func dragging(gesture: UIPanGestureRecognizer) {
    let translation  = gesture.translation(in: self.parentView)
    self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
}

// parentView
private var _parentView: UIView!

var parentView: UIView {
    set {
        _parentView = newValue
    }
    get {
        return _parentView
}


// touchesBegan
var lastLocation = CGPoint(x: 0, y: 0)

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastLocation = self.center
}


// overridehitTest
override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    print (point, super.hitTest(point, with: event))
    return super.hitTest(point, with: event)
}


// viewDidLoad() viewDidLoadHitPoint
override func viewDidLoad() {
    super.viewDidLoad()
    specialView.parentView = self.view
    specialView.backgroundColor = .blue
    specialView.center = CGPoint(x: 0, y: 0)
    specialView.tag = 0
    specialSubView.backgroundColor = .red
    specialSubView.parentView = specialView
    specialSubView.tag = 1
}


// point(inside:with:) point(inside:with:)hitpoint
override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let superBool = super.point(inside: point, with: event)
    print ("point", point, event, superBool)
    return superBool
}


// overridehittest
override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let frame = self.bounds.insetBy(dx: -20, dy: -20)
    return frame.contains(point) ? self : nil
}
