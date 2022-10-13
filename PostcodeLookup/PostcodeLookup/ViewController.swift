//
//  ViewController.swift
//  PostcodeLookup
//
//  Created by Steven Curtis on 22/04/2021.
//

import Combine
import UIKit

final class ViewController: UIViewController {
    enum Constants {
        static let reuseIdentifier = "cell"
        static let section = "section"
    }
    
    private let viewModel: ViewModel
    private lazy var tableView: UITableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<String, String>!
    private var cancellable: Set<AnyCancellable> = []
    private var searchController: UISearchController!
    private lazy var searchResultsController = SearchResultsController(
        searchResultsViewModel: SearchResultsViewModel(),
        selectedDelegate: self
    )
    
    override func loadView() {
        self.view = tableView
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupBindings()
    }
    
    private func applySnapshot(with data: [String]) {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteAllItems()
        currentSnapshot.appendSections([Constants.section])
        currentSnapshot.appendItems(data)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    private func setupComponents() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        
        setupSearchController()
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, postcode in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = postcode
            return cell
        }
        )
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type your postcode"

        let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        placeholderAppearance.font = .systemFont(ofSize: 16)

        navigationItem.searchController = searchController
    }
    
    private func setupBindings() {
        viewModel.postCodes
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { strings in
                if let results = try? strings.get() {
                    self.applySnapshot(with: results)
                }
            })
            .store(in: &cancellable)
    }
}

extension ViewController: SelectedDelegate {
    func selected(string: String) {
        viewModel.processPostCodes(selectedPostCodes: string)
    }
}
