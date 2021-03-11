//
//  LighterTableViewController.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

protocol DatasourceDelegate: class {
    func showPopup(indexPath: IndexPath)
}

class LighterTableViewController: UIViewController, DatasourceDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: LighterTableViewDataSource!
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...10 {
            dataArray.append("item " + String(i) )
        }

        self.dataSource = LighterTableViewDataSource(items: dataArray)
        dataSource.delegate = self
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
    }
    
    func showPopup(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "Row " + indexPath.row.description + " selected" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Resign", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
