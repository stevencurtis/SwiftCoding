//
//  ViewController.swift
//  ClickOnTableView
//
//  Created by Steven Curtis on 21/10/2021.
//

import UIKit

class ViewController: UIViewController {
let data = ["a", "b", "c"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell {
            cell.textLabel?.text = data[indexPath.row]
            cell.setup(with: indexPath.row)
            return cell
        }
        else {
            fatalError()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
