//
//  LighterTableViewDataSource.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import UIKit

typealias TableViewCellConfigureBlock = (_ cell: UITableViewCell, _ item: AnyObject?) -> ()
class LighterTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var dataArray = [String]()
    var configureCellBlock: TableViewCellConfigureBlock?
    weak var delegate: DatasourceDelegate?
    
    init(items: [String]){
        self.dataArray = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lightercell", for: indexPath)
        cell.textLabel?.text = (dataArray[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showPopup(indexPath: indexPath)
    }
    
    
}
