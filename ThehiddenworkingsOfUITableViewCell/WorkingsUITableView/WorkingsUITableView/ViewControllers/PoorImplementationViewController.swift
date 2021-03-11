//
//  PoorImplementationViewController.swift
//  WorkingsUITableView
//
//  Created by Steven Curtis on 25/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class PoorImplementationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cells: [UITableViewCell] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100000 {
            let cell = UITableViewCell()
            cell.textLabel?.text = i.description
            cell.imageView?.image = UIImage(named: "placeholder.png")
            cells.append(cell)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension PoorImplementationViewController: UITableViewDelegate {
    
}

extension PoorImplementationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        return cell
    }
}
