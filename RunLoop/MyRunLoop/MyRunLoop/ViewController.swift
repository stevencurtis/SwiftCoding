//
//  ViewController.swift
//  MyRunLoop
//
//  Created by Steven Curtis on 01/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    var number = 0
    var numberUpdate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Thread.current)
        print("Main Loop: \(RunLoop.main)")
        setupTableView()
        
        Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
        
        let timerUpdate = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireNumberUpdateTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timerUpdate, forMode: .common)
    }
    
    @objc func fireTimer() {
        number += 1
        tableView.reloadData()
    }
    
    @objc func fireNumberUpdateTimer() {
        numberUpdate += 1
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .red
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = number.description
            return cell
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "celltwo")
        cell.textLabel?.text = numberUpdate.description
        return cell
    }
}
