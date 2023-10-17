//
//  ViewController.swift
//  AppearView
//
//  Created by Steven Curtis on 17/10/2023.
//

import UIKit

final class ViewController: UIViewController {

    private var showMoreInfo = false {
        didSet {
            updateInfoVisibility(animated: true)
        }
    }

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "my text"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let moreInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        return view
    }()

    private var moreInfoViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        let headerLabel = UILabel()
        headerLabel.text = "More Information"
        headerLabel.textColor = .black
        headerLabel.isUserInteractionEnabled = true
        headerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleInfo)))

        chevronImageView.isUserInteractionEnabled = true
        chevronImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleInfo))
        )

        let headerStack = UIStackView(arrangedSubviews: [headerLabel, chevronImageView])
        headerStack.axis = .horizontal
        headerStack.spacing = 8

        let alwaysVisibleLabel = UILabel()
        alwaysVisibleLabel.text = "This has been here forever"
        alwaysVisibleLabel.textColor = .black
        
        moreInfoView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        moreInfoViewHeightConstraint = moreInfoView.heightAnchor.constraint(equalToConstant: 0)
        moreInfoViewHeightConstraint.isActive = true

        let mainStack = UIStackView(arrangedSubviews: [
            headerStack,
            moreInfoView,
            alwaysVisibleLabel
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
        moreInfoView.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true

        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: moreInfoView.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: moreInfoView.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        updateInfoVisibility(animated: false)
    }

    @objc private func toggleInfo() {
        showMoreInfo.toggle()
    }

    private func updateInfoVisibility(animated: Bool) {
        let newHeight: CGFloat = showMoreInfo ? 50 : 0
        let newAlpha: CGFloat = showMoreInfo ? 1 : 0

        let animation = {
            self.moreInfoViewHeightConstraint.constant = newHeight
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: self.showMoreInfo ? .pi / 2 : 0)
            self.infoLabel.isHidden.toggle()
            self.infoLabel.alpha = newAlpha
            self.view.layoutIfNeeded()
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: animation)
        } else {
            animation()
        }
    }
}
