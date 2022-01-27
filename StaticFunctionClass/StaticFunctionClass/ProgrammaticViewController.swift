//
//  ProgrammaticViewController.swift
//  StaticFunctionClass
//
//  Created by Steven Curtis on 30/12/2021.
//

import UIKit

class ProgrammaticViewController: UIViewController {
    var drawView: DrawArcView = DrawArcView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawView)
        drawView.drawArc(startDegrees: 0, endDegrees: 90)
        setupConstraints()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            drawView.topAnchor.constraint(equalTo: view.topAnchor),
            drawView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            drawView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
