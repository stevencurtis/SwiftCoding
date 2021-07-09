//
//  ViewController.swift
//  OutletsShouldBePrivate
//
//  Created by Steven Curtis on 23/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    let data = ["a", "b", "c", "d", "e"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate { }
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell {
            cell.myLabel?.text = data[indexPath.row]
//            cell.configure(text: data[indexPath.row])
            return cell
        }
        fatalError()
    }
}
