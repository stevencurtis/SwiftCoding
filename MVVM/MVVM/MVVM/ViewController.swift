//
//  ViewController.swift
//  MVVM
//
//  Created by Steven Curtis on 12/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sbView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
        let image = UIImage(named: "stuart")!
        // set model, simple details about the creature
        let stuart = Pet(name: "Stuart",
                         birthday: birthday,
                         rarity: .veryRare,
                         image: image)
        
        // the viewmodel is able to calculate the birthday and adoption fee from the model
        let viewModel = PetViewModel(pet: stuart)
        
        let frame = sbView.frame
        let view = PetView(frame: frame)

        // let the viewmodel set up the birthday, adoption fee and name etc.
        viewModel.configure(view)

        
        print (view.imageView)
        sbView.addSubview( view )

    }


}

