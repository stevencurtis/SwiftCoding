//
//  ViewController.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 17/02/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel: ViewModel
    private var label = Label()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
        
        viewModel.$labelModel
            .withUnretained(label)
            .sink {_ in } receiveValue: { (label, model) in
                label.update(with: model)
            }
            .store(in: &subscriptions)
        
        viewModel.didChange(state: .didLoad)
    }
    
    func setupHierarchy() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupComponents() {
        label.linkHandler = { index, range in
            print(index, range)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
}
