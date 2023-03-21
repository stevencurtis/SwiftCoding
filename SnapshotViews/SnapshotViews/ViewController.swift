//
//  ViewController.swift
//  SnapshotViews
//
//  Created by Steven Curtis on 22/10/2020.
//

import UIKit

class ViewController: UIViewController {
    let data = ["Some Short cell text","There is a great deal of text in this particular cell, it will take up a great deal of space and perhaps go onto four lines", "This is extremely short text", "Another long load of text that will be in a UITableViewCell"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell {
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = data[indexPath.row]
            cell.textLab?.numberOfLines = 0
            cell.textLab?.text = data[indexPath.row]
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
        }
        fatalError("Could not dequeue CustomCell")
    }
}


