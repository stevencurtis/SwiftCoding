//
//  MVCFactory.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 06/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

final public class MVCFactory {
    func create() -> SegueMVCViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mvc") as? SegueMVCViewController
        return vc
    }
}
