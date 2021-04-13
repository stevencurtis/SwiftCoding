//
//  ViewController.swift
//  LazyLoadImages
//
//  Created by Steven Curtis on 13/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let urls: [String] = [
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png"
    ]

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        self.view.addSubview(tableView)
    }
    
    private func setupComponents() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = indexPath.row.description
            cell.imageView?.image = UIImage(named: "placeholder")
            cell.imageView?.downloadImage(with: urls[indexPath.row], contentMode: UIView.ContentMode.scaleAspectFit)
            return cell
        }
        fatalError()
    }
}
