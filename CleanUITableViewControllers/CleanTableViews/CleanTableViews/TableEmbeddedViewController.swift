//
//  TableEmbeddedViewController.swift
//  CleanTableViews
//
//  Created by Steven Curtis on 16/01/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class TableEmbeddedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

{
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        for i in 0...10 {
            dataArray.append("item " + String(i) )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "embeddedcell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "Row " + indexPath.row.description + " selected" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Resign", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
