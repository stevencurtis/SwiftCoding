//
//  SBViewController.swift
//  viewDidLoadloadView
//
//  Created by Steven Curtis on 29/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SBViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

}

extension SBViewController: UITableViewDelegate {
    
}

extension SBViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.data[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    

}
