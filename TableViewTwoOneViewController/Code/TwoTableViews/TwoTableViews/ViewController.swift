//
//  ViewController.swift
//  TwoTableViews
//
//  Created by Steven Curtis on 25/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstTable: UITableView!
    @IBOutlet weak var secondTable: UITableView!

    let firstData = [1,2,3,4,5,6,7,8,9]
    let secondData = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTable.register(UITableViewCell.self, forCellReuseIdentifier: "firstcell")
        firstTable.delegate = self
        firstTable.dataSource = self
        
        secondTable.register(UITableViewCell.self, forCellReuseIdentifier: "secondcell")
        secondTable.delegate = self
        secondTable.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == firstTable {
            // you clicked the first table
            firstTable.deselectRow(at: indexPath, animated: true)
        } else {
            // you clicked the second table
            secondTable.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTable {
            return firstData.count
        }
        return secondData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTable {
            let cell = firstTable.dequeueReusableCell(withIdentifier: "firstcell", for: indexPath)
            cell.textLabel?.text = firstData[indexPath.row].description
            return cell
        } else {
            let cell = secondTable.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath)
            cell.textLabel?.text = secondData[indexPath.row]
            return cell
        }
    }
}
