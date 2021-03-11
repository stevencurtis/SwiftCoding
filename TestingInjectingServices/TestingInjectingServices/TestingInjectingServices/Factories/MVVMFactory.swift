//
//  MVVMFactory.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 06/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

final public class MVVMFactory {
    func create() -> SegueMVVMViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mvvm") as? SegueMVVMViewController
        return vc
    }
}
