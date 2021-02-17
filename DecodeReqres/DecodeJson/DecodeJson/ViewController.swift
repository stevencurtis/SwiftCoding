//
//  ViewController.swift
//  DecodeJson
//
//  Created by Steven Curtis on 17/02/2021.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel: ViewModel
    
    private lazy var text: UITextView = .init(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    func setupHierarchy() {
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupComponents() {
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.text = "Placeholder"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.completion = {
            let text = $0.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n")
            DispatchQueue.main.async {
                self.text.text = text

            }
        }
        viewModel.downloadFiles()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
