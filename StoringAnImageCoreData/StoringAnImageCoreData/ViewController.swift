//
//  ViewController.swift
//  StoringAnImageCoreData
//
//  Created by Steven Curtis on 08/10/2020.
//

import UIKit

class ViewController: UIViewController {

    private(set) var dataManager: DataManagerProtocol?

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        dataManager = DataManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let image = UIImage(named: "Placeholder")
        if let imageData = image?.pngData() {
            dataManager?.save(data: imageData, completion: { [weak self] in 
                let managedObjects = try! self?.dataManager?.getManagedObjects()
                let image = managedObjects!.map{ ($0.value(forKey: Constants.imageAttribute) ) as! Data }.first!
                self?.image.image = UIImage(data: image)
            })
        }
    }
}
