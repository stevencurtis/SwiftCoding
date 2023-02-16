//
//  ViewController.swift
//  CoreDataTransformable
//
//  Created by Steven Curtis on 08/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var dataManager: DataManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager = DataManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataManager?.save(name: "Test Name", color: UIColor.blue, completion: { [weak self] in
            let managedObjects = try! self?.dataManager?.getManagedObjects()
            let colour = managedObjects!.map{ ($0.value(forKey: Constants.colorAttribute) ) as! UIColor }.first!
            self?.view.backgroundColor = colour
        })
    }
}
