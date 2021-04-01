//
//  MusicPlayerViewController.swift
//  ChildViewControllers
//
//  Created by Steven Curtis on 30/03/2021.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    lazy private var playButton = UIButton()
    private let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        setupComponents()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupComponents() {
        self.view.addSubview(playButton)

        playButton.setImage(
            UIImage(
                systemName: "pause.fill",
                withConfiguration: largeConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal
                ),
            for: .normal
        )
        playButton.addTarget(self, action: #selector(tapped(_:)), for: .touchDown)
        playButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func tapped(_ sender: AnyObject) {
        print("tapped")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
