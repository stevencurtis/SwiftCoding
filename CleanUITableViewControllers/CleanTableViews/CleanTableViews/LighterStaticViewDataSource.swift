//
//  LighterStaticViewDataSource.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 17/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import UIKit

class LighterStaticViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dataArray = ["item 0","item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",]
    
    weak var delegate: DatasourceDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staticcell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showPopup(indexPath: indexPath)
    }
    
    
}
