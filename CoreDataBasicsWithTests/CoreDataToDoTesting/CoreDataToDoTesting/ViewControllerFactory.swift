//
//  ViewControllerFactory.swift
//  CoreDataToDoTesting
//
//  Created by Steven Curtis on 14/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

final public class ViewControllerFactory
{
    private var coreManagerClass: CoreDataManagerProtocol?
    
    func create(_ dataManager : CoreDataManagerProtocol? = nil) -> ViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        if let dataManager = dataManager {
            vc?.coreDataManager = dataManager
            return vc
        }
        vc?.coreDataManager = CoreDataManager()
        return vc
    }
}
