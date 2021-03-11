//
//  ViewController.swift
//  MVCTest
//
//  Created by Steven Curtis on 14/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var breaches: [BreachModel] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchBreaches()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func fetchBreaches() {
        // do network call
        breaches = [BreachModel(title: "000webhost"),BreachModel(title: "126")]
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = breaches[indexPath.row]
        cell.textLabel?.text = cellData.title
        return cell
    }
}

extension ViewController: UITableViewDelegate {}


public struct BreachModel {
    var title: String
}
