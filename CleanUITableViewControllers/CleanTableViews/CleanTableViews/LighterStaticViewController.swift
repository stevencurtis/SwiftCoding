//
//  LighterStaticViewController.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 17/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class LighterStaticViewController: UIViewController, DatasourceDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: LighterStaticViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = LighterStaticViewDataSource()
        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        
    }
    
    func showPopup(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "Row " + indexPath.row.description + " selected" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Resign", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
