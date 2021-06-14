//
//  MenuViewController.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import UIKit

class MenuViewController: UIViewController {
    let tableView = UITableView()
    var menuPresenter: MenuPresenterProtocol?
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(redView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        
        let exampleButton = UIButton()
        exampleButton.setTitle("test", for: .normal)
        exampleButton.translatesAutoresizingMaskIntoConstraints = false
        exampleButton.addTarget(menuPresenter, action: #selector(menuPresenter?.buttonPressed), for: .touchUpInside)
        self.view.addSubview(exampleButton)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            exampleButton.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            exampleButton.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
            exampleButton.heightAnchor.constraint(equalTo: redView.heightAnchor),
            exampleButton.widthAnchor.constraint(equalTo: redView.widthAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuPresenter?.showDetail(data: menuPresenter?.data[indexPath.row] ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuPresenter?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuPresenter?.data[indexPath.row]
        return cell
    }
}

extension MenuViewController {
    func set(presenter: MenuPresenterProtocol) {
        self.menuPresenter = presenter
    }
}
