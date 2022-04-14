//
//  ViewController.swift
//  ViewTableView
//
//  Created by Steven Curtis on 18/12/2021.
//

import UIKit

class ViewController: UIViewController {

    let viewModel: ViewModel
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
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
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupComponents() {
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = viewModel.dataSource
        
        let imageNib = UINib(nibName: "HeadingTableViewCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: "HeadingTableViewCell")

        let textNib = UINib(nibName: "TextTableViewCell", bundle: nil)
        tableView.register(textNib, forCellReuseIdentifier: "TextTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
