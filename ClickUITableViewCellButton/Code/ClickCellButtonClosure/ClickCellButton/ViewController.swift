//
//  ViewController.swift
//  ClickCellButton
//
//  Created by Steven Curtis on 06/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = ["Dave Smith", "Ahmed Khan", "Lakshmi Manchu" ,"Tom Rogers"]
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 44
        self.view = tableView
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = data[indexPath.row]
        cell.alertButton.tag = indexPath.row
        cell.closure = {
            let alert = UIAlertController(title: "Tapped Row \(indexPath.row)", message: "Thank you for tapping", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {}




