//
//  ViewController.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import UIKit

class ListViewController: UIViewController {
    var listViewModel: ListViewModel!
    var tableView: UITableView!
    
    init(viewModel: ListViewModel) {
        listViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let accountsView = UIView()
        accountsView.backgroundColor = .systemGray
        self.view = accountsView
        
        tableView = UITableView(frame: .zero)
        
        setUpTableView()
        setUpConstraints()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewModel.update = {
            self.tableView.reloadData()
        }
        listViewModel.fetchPhotos()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVM = DetailViewModel(photo: listViewModel.photos[indexPath.row])
        let detail = DetailViewController(viewModel: detailVM)
        
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listViewModel.photos[indexPath.row].title
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    
    
}
