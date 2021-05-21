//
//  DetailViewController.swift
//  MVP
//
//  Created by Steven Curtis on 07/05/2021.
//  Copyright © 2021 Steven Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    lazy var detailPresenter: DetailPresenterProtocol = DetailPresenter(view: self)
    var data: String
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init(data: String) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.textAlignment = .center
        self.view.addSubview(label)
        label.text = data
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
