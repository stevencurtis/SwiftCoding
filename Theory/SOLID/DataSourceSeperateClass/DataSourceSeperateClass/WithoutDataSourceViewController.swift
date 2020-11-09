//
//  WithoutDataSourceViewController.swift
//  DataSourceSeperateClass
//
//  Created by Steven Curtis on 06/10/2020.
//

import UIKit

class WithoutDataSourceViewController: UIViewController {
    let dataSource = MyDataSource()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

extension WithoutDataSourceViewController: UITableViewDelegate {}

class MyDataSource: NSObject, UITableViewDataSource {
    var data = ["a","b","c"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
