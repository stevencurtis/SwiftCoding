//
//  ViewController.swift
//  DIIOS12
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "traverseSegue" {
            if let detail = segue.destination as? DetailViewController {
                detail.item = "test"
            }
        }
    }

    @IBAction func buttAction(_ sender: UIButton) {
        let detailViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as UIViewController

        if let detail = detailViewController as? DetailViewController {
            detail.item = "test"
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        traverseToInfo()
    }
    
    var viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
    
    func traverseToInfo() {
        let vc = viewControllerFactory.createInfoViewControllerWith(item: "test")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
