//
//  ViewController.swift
//  InsetUITableViewCell
//
//  Created by Steven Curtis on 23/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let data = ["a", "b", "c", "d"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "SubclassedTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubclassedTableViewCell
        cell.textLabel?.text = data[indexPath.row]
        cell.leftInset = 50
        cell.rightInset = -20
        cell.bottomInset = -20
        return cell
    }
}
