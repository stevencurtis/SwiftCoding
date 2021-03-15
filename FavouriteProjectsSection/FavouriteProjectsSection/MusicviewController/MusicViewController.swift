//
//  MusicViewController.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import UIKit

class MusicViewController: UIViewController {
    let viewModel: MusicViewModelProtocol
    init(viewModel: MusicViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    lazy var playButton = UIImageView(frame: .zero)
    lazy var pauseButton = UIImageView(frame: .zero)
    lazy var imageView = UIImageView(frame: .zero)
    lazy var stackView = UIStackView(frame: .zero)
    lazy var containerView = UIView(frame: .zero)
    lazy var controlsStackView = UIStackView(frame: .zero)
    lazy var controlsHorizontalStackView = UIStackView(frame: .zero)
    lazy var label = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        setupHierarchy()
        setupViews()
        setupConstaints()
    }
    
    func setupHierarchy() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(controlsStackView)
        controlsStackView.addArrangedSubview(label)
        controlsStackView.addArrangedSubview(containerView)
        containerView.addSubview(controlsHorizontalStackView)
        controlsHorizontalStackView.addArrangedSubview(playButton)
        controlsHorizontalStackView.addArrangedSubview(pauseButton)
    }
    func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        controlsHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        controlsStackView.axis = .vertical
        playButton.image = UIImage(named: "play")
        playButton.contentMode = .scaleAspectFit
        pauseButton.image = UIImage(named: "pause")
        pauseButton.contentMode = .scaleAspectFit
        
        controlsHorizontalStackView.alignment = .center
        controlsHorizontalStackView.distribution = .equalCentering
        
        label.text = viewModel.album.name
        label.textAlignment = .center
        
        stackView.axis = .vertical
        
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: viewModel.album.image), placeholderImage: UIImage(named: "placeholder"))
    }
    func setupConstaints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlsHorizontalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}
