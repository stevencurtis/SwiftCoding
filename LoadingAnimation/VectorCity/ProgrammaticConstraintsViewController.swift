//
//  ProgrammaticConstraintsViewController.swift
//  VectorCity
//
//  Created by Steven Curtis on 15/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ProgrammaticConstraintsViewController: UIViewController {
    
    let city = UIImageView()
    let city2 = UIImageView()
    let manImage = UIImageView()
    var manImageList = [UIImage]()
    var tree0 = UIImageView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.10, delay: 0, options: [], animations: {
            self.tree0.alpha = 0.0
            self.city2.alpha = 0.0
            self.city.alpha = 0.0
            self.manImage.alpha = 0.0
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tree0.alpha = 0.0
        manImage.alpha = 0.0
        city2.alpha = 0.0
        city.alpha = 0.0
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        animate(duration: 8.0, delay: 0.0)
    }
    
    func animate(duration: TimeInterval, delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.tree0.alpha = 1.0
            self.city.alpha = 1.0
            self.city2.alpha = 1.0
            self.manImage.alpha = 1.0
        }, completion: nil)
        
        // tree must disappear off the screen, so -50
        let treeAnimation = CABasicAnimation(keyPath: "position.x")
        treeAnimation.duration = duration
        let treeMid: Double = Double(self.city.frame.size.width)
        treeAnimation.fromValue = NSNumber(value: treeMid)
        treeAnimation.toValue = NSNumber(value: -50 )
        treeAnimation.repeatCount = .infinity
        self.tree0.layer.add(treeAnimation, forKey: "basic")
        
        let firstCityAnimation = CABasicAnimation(keyPath: "position.x")
        firstCityAnimation.duration = duration
        firstCityAnimation.fromValue = NSNumber(value: 0.0)
        firstCityAnimation.toValue = NSNumber(value: -1 * Int(self.city.frame.size.width))
        firstCityAnimation.repeatCount = .infinity
        self.city.layer.add(firstCityAnimation, forKey: "basic")
        
        let secondCityAnimation = CABasicAnimation(keyPath: "position.x")
        secondCityAnimation.duration = duration
        secondCityAnimation.fromValue = NSNumber(value: Int(self.city.frame.size.width) )
        secondCityAnimation.toValue = NSNumber(value: 0 )
        secondCityAnimation.repeatCount = .infinity
        self.city2.layer.add(secondCityAnimation, forKey: "basic")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(displayP3Red: 238/255, green: 240/255, blue: 238/255, alpha: 1.0)
        
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        guard let backgroundImage = UIImage(named:"city") else {return}
        city.image = backgroundImage
        city.clipsToBounds = true
        self.view.addSubview(city)
        city.translatesAutoresizingMaskIntoConstraints = false
        
        city2.image = backgroundImage
        city2.clipsToBounds = true
        self.view.addSubview(city2)
        city2.translatesAutoresizingMaskIntoConstraints = false
        
        let ratio: CGFloat = 3809 / 1257
        
        guard let treeImage = UIImage(named: "tree0") else {return}
        tree0.image = treeImage
        tree0.clipsToBounds = true
        tree0.translatesAutoresizingMaskIntoConstraints = false
        tree0.contentMode = .scaleAspectFit
        self.view.addSubview(tree0)
        
        manImage.contentMode = .scaleAspectFit
        manImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(manImage)
        
        NSLayoutConstraint.activate([
            city.heightAnchor.constraint(equalToConstant: 300),
            city.widthAnchor.constraint(equalTo: city.heightAnchor, multiplier: ratio),
            city.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: (navHeight ?? 0)),
            city.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            city2.heightAnchor.constraint(equalToConstant: 300),
            city2.widthAnchor.constraint(equalTo: city2.heightAnchor, multiplier: ratio),
            city2.leadingAnchor.constraint(equalTo: city.trailingAnchor),
            city2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: (navHeight ?? 0)),
            manImage.widthAnchor.constraint(equalToConstant: 97),
            manImage.heightAnchor.constraint(equalToConstant: 97),
            manImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            manImage.bottomAnchor.constraint(equalTo: self.city.bottomAnchor),
            tree0.bottomAnchor.constraint(equalTo: self.city.bottomAnchor),
            tree0.heightAnchor.constraint(equalToConstant: 150),
            tree0.widthAnchor.constraint(equalTo: tree0.widthAnchor, multiplier: 1.0)
        ])
        
    }
    
}
