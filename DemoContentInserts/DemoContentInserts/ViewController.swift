//
//  ViewController.swift
//  DemoContentInserts
//
//  Created by Steven Curtis on 09/02/2025.
//



import UIKit

final class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    lazy var buttonStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    lazy var modalButton = {
        let button = UIButton()
        button.setTitle("Show Modal", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var contentInsertsButton = {
        let button = UIButton()
        button.setTitle("Show Content Inserts", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(modalButton)
        buttonStack.addArrangedSubview(contentInsertsButton)
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        modalButton.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        contentInsertsButton.addTarget(self, action: #selector(showContent), for: .touchUpInside)
    }
    @objc func showContent() {
        let viewModel = ContentViewModel()
        let viewController = ContentViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func showModal() {
        let viewModel = ViewModel()

        present(ModelViewController(viewModel: viewModel), animated: true)
    }

}

