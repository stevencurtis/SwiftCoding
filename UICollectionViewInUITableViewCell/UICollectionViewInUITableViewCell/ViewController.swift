//
//  ViewController.swift
//  UICollectionViewInUITableViewCell
//
//  Created by Steven Curtis on 12/11/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data = [[UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.brown, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green], [UIColor.blue, UIColor.green]]
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "tablecell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? MyTableViewCell {
            cell.selectionStyle = .none
            cell.updateCellWith(row: data[indexPath.row])
            return cell
        }
        fatalError("Unable to dequeReusableCell")
    }
}
