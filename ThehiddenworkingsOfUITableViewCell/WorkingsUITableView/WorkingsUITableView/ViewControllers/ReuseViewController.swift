//
//  ReuseViewController.swift
//  WorkingsUITableView
//
//  Created by Steven Curtis on 25/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ReuseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data : [String] = []
    
    var task: URLSessionDownloadTask!
    var session: URLSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100000 {
            data.append(i.description)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: "ReusableTableViewCell")

    }
}

extension ReuseViewController: UITableViewDelegate {
    
}

extension ReuseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableViewCell", for: indexPath)
        cell.imageView?.image = UIImage(named: "placeholder.png")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    

}
