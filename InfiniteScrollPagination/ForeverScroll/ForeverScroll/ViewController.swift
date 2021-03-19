//
//  ViewController.swift
//  ForeverScroll
//
//  Created by Steven Curtis on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModelProtocol
    var tableView = UITableView()
    var fetchingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.closure = {
            self.tableView.reloadData()
            self.fetchingMore = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                fetchingMore = true
                viewModel.fetch()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.data.count
        default:
            if fetchingMore {return 1} else {return 0}
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = viewModel.data[indexPath.row]
            case 1:
                cell.textLabel?.text = ""
                let spinner = UIActivityIndicatorView(frame: cell.frame)
                cell.addSubview(spinner)
                spinner.startAnimating()
            default: break
            }
            
            return cell
        }
        fatalError()
    }
}
