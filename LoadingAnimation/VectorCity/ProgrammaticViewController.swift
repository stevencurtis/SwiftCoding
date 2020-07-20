//
//  ProgrammaticViewController.swift
//  VectorCity
//
//  Created by Steven Curtis on 15/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

// No Constraints: Without constraints rotation is NOT recommended!
class ProgrammaticViewController: UIViewController {
    
    let city = UIImageView()
    let city2 = UIImageView()
    let manImage = UIImageView()
    var manImageList = [UIImage]()
    let tree0 = UIImageView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.10, delay: 0, options: [], animations: {
            self.tree0.alpha = 0.0
            self.city2.alpha = 0.0
            self.city.alpha = 0.0
            self.manImage.alpha = 0.0
        }, completion: nil)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseOut], animations: {
            self.tree0.alpha = 1.0
            self.city.alpha = 1.0
            self.city2.alpha = 1.0
            self.manImage.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 8.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            self.city.frame = self.city.frame.offsetBy(dx: -1 * self.city.frame.size.width, dy: 0.0)
            self.city2.frame = self.city2.frame.offsetBy(dx: -1 * self.city2.frame.size.width, dy: 0.0)
            self.tree0.frame = self.tree0.frame.offsetBy(dx: -1 * self.city2.frame.size.width * 2, dy: 0.0)
        }, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let backgroundImage = UIImage(named:"city") else {return}
        city.image = backgroundImage
        city.clipsToBounds = true
        
        guard let treeImage = UIImage(named: "tree0") else {return}
        tree0.image = treeImage
        tree0.clipsToBounds = true

        let navHeight = self.navigationController?.navigationBar.frame.height

        city.frame = CGRect(
            x: self.view.frame.origin.x,
            y: (self.view.frame.maxY / 2) - 150 + (navHeight ?? 00),
            width: 910,
            height: 300)
        self.view.addSubview(city)

        city2.image = backgroundImage
        city2.frame = CGRect(
            x: city.frame.size.width,
            y: (self.view.frame.maxY / 2) - 150 + (navHeight ?? 00),
            width: 910,
            height: 300)
        self.view.addSubview(city2)
        
        tree0.frame = CGRect(
            x: view.frame.width + 150,
            y: city.frame.maxY - (150),
            width: 150,
            height: 150)
        self.view.addSubview(tree0)
        
        manImage.frame = CGRect(
            x: view.frame.width / 2 - 48,
            y: city.frame.maxY - (97),
            width: 97,
            height: 97)
        self.view.addSubview(manImage)
        
        manImage.alpha = 0.0
        city2.alpha = 0.0
        city.alpha = 0.0
        tree0.alpha = 0.0

        animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tree0.contentMode = .scaleAspectFit
        
        manImage.contentMode = .scaleAspectFit

        
        for i in 0...3 {
            guard let img = UIImage(named: String(i)) else {return}
            manImageList.append(img)
            if i == 3 {
                self.manImage.animationImages = self.manImageList
                self.manImage.animationDuration = 0.50
                self.manImage.startAnimating()
            }
        }
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(displayP3Red: 238/255, green: 240/255, blue: 238/255, alpha: 1.0)
    }
}
