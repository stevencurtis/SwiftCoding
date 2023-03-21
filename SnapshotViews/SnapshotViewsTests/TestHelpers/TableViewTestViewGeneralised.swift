//
//  TableViewTestViewGeneralised.swift
//  SnapshotViewsTests
//
//  Created by Steven Curtis on 23/10/2020.
//

import Foundation

import UIKit
@testable import SnapshotViews

class TableViewTestViewGeneralised<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    
    init(height: Double, configureCell: @escaping (Cell) -> ()) {
        self.configureCell = configureCell
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: height))
        setUpTableView()
    }
    
    func setUpTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    private let configureCell: (Cell) -> ()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? Cell {
            configureCell(dequeuedCell)
            return dequeuedCell
        }
        fatalError("Could not dequeue CustomCell")
    }
}
