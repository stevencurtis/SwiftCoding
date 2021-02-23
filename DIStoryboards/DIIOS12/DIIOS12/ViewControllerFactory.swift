//
//  ViewControllerFactory.swift
//  DIIOS12
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

protocol ViewControllerFactoryProtocol {
    func createInfoViewControllerWith(item: String) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    let storyboard: UIStoryboard

    func createInfoViewControllerWith(item: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InformationViewController
        vc.item = item
        return vc

    }
    
    init(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) {
        self.storyboard = storyboard
    }
}
