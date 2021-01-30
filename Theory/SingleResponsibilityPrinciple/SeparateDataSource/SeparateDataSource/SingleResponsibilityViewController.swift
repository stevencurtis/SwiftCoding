//
//  SingleResponsibilityViewController.swift
//  SeparateDataSource
//
//  Created by Steven Curtis on 06/10/2020.
//

import UIKit

class SingleResponsibilityViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = DataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
}

extension SingleResponsibilityViewController: UITableViewDelegate {}

class DataSource: NSObject, UITableViewDataSource {
    let data = ["1","2","3","4","5"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
