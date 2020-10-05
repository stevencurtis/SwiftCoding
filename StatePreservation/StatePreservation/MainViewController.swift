//
//  ViewController.swift
//  StatePreservation
//
//  Created by Steven Curtis on 03/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var data = [
        "Apples",
        "Peanuts",
        "Cheese",
        "Canned Squirrel",
        "Water",
        "Pen",
        "Chocolate",
        "Coke",
        "Staples",
        "Generic snacks",
        "Glasses",
        "Wine",
        "Pure Ethonol",
        "Toothpaste",
        "Toothbrush",
        "Resentment",
        "Christmas card",
        "Nail Polish",
        "Happiness"
    ]
    
    let restorationID = "tableviewrestorisation"
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        tableView = UITableView(frame: self.view.bounds)
        guard let tableView = tableView else {return}
        
        tableView.restorationIdentifier = restorationID
        
        view.addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

extension MainViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(data, forKey: restorationID)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let returnedData = coder.decodeObject(forKey: restorationID) as? [String]{
            data = returnedData
        }
    }
}

extension MainViewController: UITableViewDelegate {}

