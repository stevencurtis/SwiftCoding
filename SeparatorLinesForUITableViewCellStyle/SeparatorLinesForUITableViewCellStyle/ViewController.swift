//
//  ViewController.swift
//  SeparatorLinesForUITableViewCellStyle
//
//  Created by Steven Curtis on 13/04/2021.
//

import UIKit

class ViewController: UIViewController {
    enum Constants {
        static let reuseIdentifier = "cell"
    }
    
    lazy var tableView = UITableView()
    
    let urls: [String] = [
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/5.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png"
    ]
    
    let names: [String] = [
        "charmeleon",
        "ivysaur",
        "venusaur"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupViews()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
    }
    
    private func setupViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorInset = .zero
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.reuseIdentifier)
        }
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = "Click for Detail"
        cell.imageView?.image = UIImage(named: "placeholder")
        cell.imageView?.downloadImage(with: urls[indexPath.row], contentMode: .scaleAspectFit)
        
        return cell
    }
}
