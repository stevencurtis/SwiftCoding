//
//  DetailViewController.swift
//  UIViewControllerAnimatedTransitioning
//
//  Created by Steven Curtis on 18/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var person: PeopleModel?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        imageView.image = UIImage(named: person!.image)
    }
}
