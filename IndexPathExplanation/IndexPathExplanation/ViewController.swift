//
//  ViewController.swift
//  IndexPathExplanation
//
//  Created by Steven Curtis on 18/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let firstData = ["a", "b", "c", "d", "e", "f"]
    let secondData = ["g", "h", "i", "j", "k"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("The indexPath is: \(indexPath), the row is: \(indexPath.row) and section is: \(indexPath.section)")
    }
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return firstData.count
        case 1: return secondData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = firstData[indexPath.row]
                cell.backgroundColor = .gray
            case 1:
                cell.textLabel?.text = secondData[indexPath.row]
                cell.backgroundColor = .lightGray
            default:
                fatalError("Unknown section")
            }
            return cell
        }
        fatalError()
    }
}

