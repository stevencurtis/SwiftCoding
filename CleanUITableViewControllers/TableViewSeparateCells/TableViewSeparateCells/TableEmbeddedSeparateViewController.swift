//
//  TableEmbeddedSeparateViewController.swift
//  TableViewSeparateCells
//
//  Created by Steven Curtis on 30/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class TableEmbeddedSeparateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [String]()
    override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
        
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil);
        tableView.register(nib, forCellReuseIdentifier: "cell")
    
    
    for i in 0...10 {
    dataArray.append("item " + String(i) )
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
