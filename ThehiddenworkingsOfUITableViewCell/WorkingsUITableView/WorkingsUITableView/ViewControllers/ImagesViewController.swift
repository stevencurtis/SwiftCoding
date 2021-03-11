//
//  ImagesTableViewController.swift
//  WorkingsUITableView
//
//  Created by Steven Curtis on 25/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var data : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100000 {
            data.append(i.description)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let cellNib = UINib(nibName: "ReusableTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ReusableTableViewCell")
    }
}

extension ImagesViewController: UITableViewDelegate {}

extension ImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableViewCell", for: indexPath)

        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}
