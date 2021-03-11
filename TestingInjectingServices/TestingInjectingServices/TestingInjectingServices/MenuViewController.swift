//
//  ViewController.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segueMVC(_ sender: UIButton) {
        performSegue(withIdentifier: "menuMVC", sender: nil)
    }
    
    @IBAction func segueMVVM(_ sender: UIButton) {
        performSegue(withIdentifier: "menuMVVM", sender: nil)

    }
    
    @IBAction func programmaticMVC(_ sender: UIButton) {
        // Instantiate from the storyboard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "mvc") as! SegueMVCViewController
        vc.serviceManager = ServiceManager()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func progammaticMVVM(_ sender: UIButton) {
        // Instantiate from the storyboard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "mvvm") as! SegueMVVMViewController
        vc.serviceManager = ServiceManager()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func factoryMVC(_ sender: UIButton) {
        guard let vc = MVCFactory().create() else {return}
        vc.serviceManager = ServiceManager()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func factoryMVVM(_ sender: UIButton) {
        guard let vc = MVVMFactory().create() else {return}
        vc.serviceManager = ServiceManager()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuMVC" {
            let destination = segue.destination as! SegueMVCViewController
            destination.serviceManager = ServiceManager()
        }
        
        if segue.identifier == "menuMVVM" {
            let destination = segue.destination as! SegueMVVMViewController
                destination.serviceManager = ServiceManager()
        }
        
    }
    

}

