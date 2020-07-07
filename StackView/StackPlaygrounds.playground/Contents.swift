import UIKit
import PlaygroundSupport

//let rootView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//rootView.backgroundColor = UIColor.blue
//
//
//var myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
//myStackView.alignment = .fill
//myStackView.distribution = .equalSpacing
//
//
//var myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//myView.backgroundColor = .red
//myView.heightAnchor.constraint(equalTo: myView.widthAnchor).isActive = true
////myView.widthAnchor.constraint(equalTo: myView.heightAnchor).isActive = true
//
//
//myStackView.addArrangedSubview(myView)
//
//rootView.addSubview(myStackView)
//PlaygroundPage.current.liveView = rootView

// drand48


let standardFrame = CGRect(x: 0, y: 0, width: 200, height: 40)


let views = [UIView(), UIView(), UIView()]

for view in views {
    view.backgroundColor = .red
    view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
}

let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
stackView.backgroundColor = UIColor.red

stackView.alignment = .fill
stackView.distribution = .fill
stackView.spacing = 10


stackView.addArrangedSubview(views[0])
stackView.addArrangedSubview(views[1])
stackView.addArrangedSubview(views[2])

stackView
