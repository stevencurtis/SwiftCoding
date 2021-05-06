//
//  ViewController.swift
//  StatePreservation
//
//  Created by Steven Curtis on 05/05/2021.
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
    
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        tableView = UITableView(frame: self.view.bounds)
        guard let tableView = tableView else {return}
        
        
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
        coder.encode(tableView?.contentOffset.y, forKey: "tableView.contentOffset.y")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let tableViewY = coder.decodeObject(forKey: "tableView.contentOffset.y") as? CGFloat {
            tableView?.contentOffset.y = tableViewY
        }
    }
}

extension MainViewController: UITableViewDelegate {}

