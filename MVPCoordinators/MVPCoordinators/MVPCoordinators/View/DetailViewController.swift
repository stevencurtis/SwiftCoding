//
//  DetailViewController.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var detailPresenter: DetailPresenter?
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

extension DetailViewController {
    func set(presenter: DetailPresenter) {
        self.detailPresenter = presenter
    }
}
