//
//  StandardTableViewController.swift
//  TableViewSeparateCells
//
//  Created by Steven Curtis on 30/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class StandardTableViewController: UITableViewController {
    
    var dataArray = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...10 {
            dataArray.append("item " + String(i) )
        }
        
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil);
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Standard UITableViewController with headerView"
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "Row " + indexPath.row.description + " selected" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Resign", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}
