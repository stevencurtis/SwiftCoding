//
//  SimpleTableViewController.swift
//  CaseIterable
//
//  Created by Steven Curtis on 25/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SimpleTableViewController: UITableViewController {

    private var items: [Animal] = []
    
    private let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (Animals.allCases)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Animals.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Animals.allCases[section].items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Animals.allCases[section].rawValue
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.text = Animals.allCases[indexPath.section].items[indexPath.row].name
        return cell!
    }

}
