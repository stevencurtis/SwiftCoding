//
//  TableViewController.swift
//  VIPERExample
//
//  Created by Steven Curtis on 22/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

protocol TableViewControllerProtocol {
    func refresh()
    var navigationController: UINavigationController? { get }
}

class TableViewController: UIViewController, TableViewControllerProtocol {
    
    var presenter: TableViewPresenter?
    let table = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        TableViewWireframe.createViewModule(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let bgView = UIView()
        self.view = bgView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        setupTable()
        setupConstraints()
        
        presenter?.loadData()
    }
    
    func refresh() {
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupTable() {
        table.delegate = self
        table.dataSource = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.moveToDetail(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.photos[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
