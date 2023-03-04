//
//  MenuViewController.swift
//  ProgrammaticConstraints
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var menuStackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var ordinaryButton: UIButton = {
       let bv = UIButton()
        bv.setTitle("Ordinary version", for: .normal)
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.addTarget(self, action: #selector(goOrdinary), for: .touchDown)
        return bv
    }()
    
    lazy var lazyButton: UIButton = {
       let bv = UIButton()
        bv.setTitle("Lazy version", for: .normal)
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.addTarget(self, action: #selector(goLazy), for: .touchDown)
        return bv
    }()
    
    @objc func goOrdinary() {
        self.navigationController?.pushViewController(OrdinaryViewController(), animated: true)
    }
    
    @objc func goLazy() {
        self.navigationController?.pushViewController(LazyViewController(), animated: true)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .green
        self.view = view
        self.view.addSubview(menuStackView)
        menuStackView.addArrangedSubview(ordinaryButton)
        menuStackView.addArrangedSubview(lazyButton)
        applyConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            menuStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }


}

