//
//  ViewController.swift
//  UnderstandingConvertPoint
//
//  Created by Steven Curtis on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var view1: UIView = {
        // setup `UIView` instance
        let view = UIView()
        // set the colour
        view.backgroundColor = .blue
        // let me take care of the layout
        view.translatesAutoresizingMaskIntoConstraints = false
        // create a `UITapGestureRecognizer` - the target is ViewController, and the function to be run is the tap function defined in this class
        let touch = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        // add the gesture to this view
        view.addGestureRecognizer(touch)
        // return this view
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        let touch = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)) )
        view.addGestureRecognizer(touch)
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        let touch = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)) )
        view.addGestureRecognizer(touch)
        return view
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        print (sender.location(in: sender.view))
        print (sender.location(in: self.view))
        print( self.view.convert(sender.location(in: self.view), to: sender.view) )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            view1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view1.heightAnchor.constraint(equalToConstant: 100),
            view1.widthAnchor.constraint(equalToConstant: 100),
            view2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view2.topAnchor.constraint(equalTo: self.view.topAnchor),
            view2.heightAnchor.constraint(equalToConstant: 100),
            view2.widthAnchor.constraint(equalToConstant: 100),
            view3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view3.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view3.heightAnchor.constraint(equalToConstant: 100),
            view3.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

