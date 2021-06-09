//
//  ViewController.swift
//  HostingController
//
//  Created by Steven Curtis on 23/04/2021.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    enum Constants {
        static let padding: CGFloat = 15.0
    }
    let viewModel: ViewModel
    let swiftUIView = PurpleUIView()
    lazy var hostingViewController = UIHostingController(rootView: swiftUIView)
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    func setupHierarchy() {
        self.view.addSubview(hostingViewController.view)
    }
        
    func setupComponents() {
        hostingViewController.rootView.buttonCallback = {
            let detailViewModel = DetailViewModel()
            let detailView = DetailView(viewModel: detailViewModel)
            let hostingController = UIHostingController(rootView: detailView)
            self.navigationController?.pushViewController(hostingController, animated: true)
        }
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
        
    }
}
