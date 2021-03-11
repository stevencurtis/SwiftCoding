//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Steven Curtis on 14/10/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var breaches: [BreachModel] = []
    
    var breachesViewModel = BreachViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchBreaches()
    }
    
    func fetchBreaches() {
        // do network call
        breachesViewModel.fetchBreaches(completion: { [weak self] _ in
            self?.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDelegate {}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breachesViewModel.breaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = breachesViewModel.breaches[indexPath.row]
        cell.textLabel?.text = cellData.title
        return cell
    }
    
    
    
}

