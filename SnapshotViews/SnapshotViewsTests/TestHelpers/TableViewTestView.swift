//
//  TableViewTestView.swift
//  SnapshotViewsTests
//
//  Created by Steven Curtis on 23/10/2020.
//

import UIKit
@testable import SnapshotViews

class TableViewTestView: UIView, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var text: String?
    
    init(testText: String, height: Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: height))
        text = testText
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell {
            
            cell.textLab?.numberOfLines = 0
            cell.textLab?.text = text
            return cell
        }
        fatalError("Could not dequeue CustomCell")
    }
}
