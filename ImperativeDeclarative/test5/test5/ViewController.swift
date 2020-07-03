//
//  ViewController.swift
//  test5
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let strings = ["1", "2", "3", "4", "5"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = strings[indexPath.row]
        return cell!
    }

    var tableView : UITableView!

    override func loadView() {
        self.tableView = UITableView()
        self.view = tableView

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

