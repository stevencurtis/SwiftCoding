//
//  DetailViewController.swift
//  DIIOS13
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .purple
    }
    
    let item: String

    required init?(coder: NSCoder, item: String) {
      self.item = item
      super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
