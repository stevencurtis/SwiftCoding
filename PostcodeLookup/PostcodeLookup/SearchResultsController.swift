//
//  SearchResultsController.swift
//  PostcodeLookup
//
//  Created by Steven Curtis on 23/04/2021.
//

import Combine
import UIKit

protocol SelectedDelegate {
    func selected(string: String)
}

final class SearchResultsController: UIViewController, UISearchResultsUpdating {
    enum Constants {
        static let reuseIdentifier = "cell"
        static let section: String = "section"
    }
    let tableView: UITableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<String, String>!
    var cancellable: Set<AnyCancellable> = []
    let searchResultsViewModel: SearchResultsViewModel
    let selectedDelegate: SelectedDelegate

    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else {return}
        if let text = searchController.searchBar.text, !text.isEmpty {            self.searchResultsViewModel.keyWordSearch = text
        }
    }
    
    init(searchResultsViewModel: SearchResultsViewModel, selectedDelegate: SelectedDelegate) {
        self.searchResultsViewModel = searchResultsViewModel
        self.selectedDelegate = selectedDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupBindings()
    }
    
    private func setupBindings() {
        searchResultsViewModel.autocompleteResults
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { vals in
                self.applySnapshot()
            })
            .store(in: &cancellable)
    }
    
    private func applySnapshot() {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteAllItems()
        currentSnapshot.appendSections([Constants.section])
        currentSnapshot.appendItems(searchResultsViewModel.autocompleteResults.value)
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
    private func setupComponents() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        tableView.delegate = self
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, autocompletion in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.reuseIdentifier,
                for: indexPath
            )
            cell.textLabel?.text = autocompletion
            return cell
        })
    }
}

extension SearchResultsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDelegate.selected(string: searchResultsViewModel.autocompleteResults.value[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension SearchResultsController: UISearchBarDelegate {}
