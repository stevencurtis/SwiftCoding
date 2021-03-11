//
//  ViewController.swift
//  CoreDataToDoTesting
//
//  Created by Steven Curtis on 14/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var alert: AlertViewController?
    var coreDataManager: CoreDataManagerProtocol?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @IBAction func addItem(_ sender: Any) {
        alert = UIStoryboard(name: Constants.alertStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.alerts.mainAlert) as? AlertViewController
        alert?.title = "Enter your task"
        alert?.presentToWindow()
        alert?.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = coreDataManager?.getTasks().count ?? 0
        return (rows == 0 ? 1 : rows)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let tasks = coreDataManager?.getTasks() else {return cell}
        if tasks.count == 0 {
            cell.textLabel?.text = "Press + to enter your task"
            return cell
        }
        let data = coreDataManager?.getTasks()[indexPath.row]
        cell.textLabel?.text = data?.value(forKey: Constants.entityNameAttribute) as? String
        return cell
    }
}

extension ViewController: AlertsDelegate {
    func textValue(textFieldValue: String) {
        coreDataManager?.save(task: textFieldValue)
        tableView.reloadData()
    }
}


// class factory method
protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String? { get }
}



