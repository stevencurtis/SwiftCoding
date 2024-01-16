//
//  ViewController.swift
//  CollapsableTableViewCellProject
//
//  Created by Steven Curtis on 06/12/2023.
//

import UIKit

final class CollapsibleTableCellViewController: UIViewController {
    struct CellData {
        var likeCount: Int
        var expanded: Bool
    }
    private lazy var tableView = UITableView()
    private lazy var data = makeData()

    private func makeData() -> [CellData] {
        var data: [CellData] = []
        for _ in 0..<20 {
            let cellData = CellData(
                likeCount: 0,
                expanded: false
            )
            data.append(cellData)
        }
        return data
    }
    
    private func updateData(with indexPath: IndexPath) {
        data[indexPath.row].expanded = true
        data[indexPath.row].likeCount += 1
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
        static let estimatedRowHeight: CGFloat = 100
        static let postsTableViewAccessibilityIdentifier = "PostsTableView"
        static let postLabelAccessibilityIdentifier = "PostLabel"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupComponents() {
        tableView.register(
            CollapsibleCell.self,
            forCellReuseIdentifier: Constants.cellReuseIdentifier
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.accessibilityIdentifier = Constants.postsTableViewAccessibilityIdentifier
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ]
        )
    }
}

extension CollapsibleTableCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier) as? CollapsibleCell else {
            debugPrint("Error: Unable to dequeue cell")
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let cellData = data[indexPath.row]
        cell.expandableView.isHidden = !cellData.expanded
        cell.count = cellData.likeCount
        cell.onButtonClicked = { [weak self] in
            self?.updateData(with: indexPath)
        }

        return cell
    }
}

extension CollapsibleTableCellViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
