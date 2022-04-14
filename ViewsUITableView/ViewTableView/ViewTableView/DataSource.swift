//
//  DataSource.swift
//  ViewTableView
//
//  Created by Steven Curtis on 18/12/2021.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {
    var cells: [CellType] = []
    
    enum CellType: Equatable {
        case heading(String)
        case text(String)
    }
    
    init(data: [String]) {
        super.init()
        populateTable(with: data)
    }
    
    private func populateTable(with info: [String]) {
        guard info.count == 3 else {return}
        cells.append(.heading(info[0]))
        cells.append(.text(info[1]))
        cells.append(.text(info[2]))
    }
    
    func cellType(at indexPath: IndexPath) -> CellType {
        cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType(at: indexPath) {
        case let .text(title):
            if let cell: TextTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell {
                cell.configure(with: title)
                return cell
            }
            fatalError()
        case let .heading(title):
            if let cell: HeadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell", for: indexPath) as? HeadingTableViewCell {
                cell.configure(with: title)
                return cell
            }
            fatalError()
        }
    }
}
