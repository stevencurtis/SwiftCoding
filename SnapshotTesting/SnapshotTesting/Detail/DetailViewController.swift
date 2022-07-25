//
//  DetailViewController.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    let viewModel: DetailViewModel!
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PlaceholderImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        setupImageView()
        setupConstraints()
    }
    
    func setupImageView(){
        self.view.addSubview(profileImageView)
        if let imageURL = viewModel.photo.pictureURL {
            profileImageView.downloadImageFrom(with: imageURL, contentMode: .scaleAspectFit)
        }
        // there is an opportunity here to inform the user if the URL is not valid
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 300),
            profileImageView.heightAnchor.constraint(equalToConstant: 300),
            profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
}
