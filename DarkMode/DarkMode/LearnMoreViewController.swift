//
//  LearnMoreViewController.swift
//  DarkMode
//
//  Created by Steven Curtis on 20/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class LearnMoreViewController: UIViewController {
    
    // called when layout is changed, perhaps an orientation change
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // reset dynamic colors
        }
    }
    
    override func loadView() {
        
        // returns Optional([1.0, 1.0]) or Optional([0.0, 1.0]) depending on light or dark mode
        print (myColor.cgColor.components as Any)
        
        // 1
//        let traitCollection = view.traitCollection
//        let resolvedColor = myColor.resolvedColor(with: traitCollection)
//        // set border color, or similar Core Graphics color
//
//        // 2
//        traitCollection.performAsCurrent {
//            // set border color, or similar Core Graphics color
//        }
//
//        // 3
//        UITraitCollection.current = traitCollection
//        // set border color, or similar Core Graphics color
        
        
        view = UIView()

        view.backgroundColor = .systemBackground
        
        
        let starImageView = configureStarImageView()
        view.addSubview(starImageView)

        let titleLabel = configureTitleLabel()
        view.addSubview(titleLabel)

        let backgroundImageView = configureBackgroundImageView()
        view.addSubview(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = configureBlurView(blurEffect)
        view.addSubview(blurView)

        let vibrancyView = configureVibrancyView(blurEffect)
        blurView.contentView.addSubview(vibrancyView)

        let vibrantLabel = configureVibrantLabel()
        vibrancyView.contentView.addSubview(vibrantLabel)

        setupConstraints()
    }
    
    
    let starImageView = UIImageView(image: #imageLiteral(resourceName: "star"))

    func configureStarImageView() -> UIImageView {
        starImageView.translatesAutoresizingMaskIntoConstraints = false

        // which has light and dark variants:
        starImageView.tintColor = UIColor(named: "LightAndDarkHeaderColor")
        return starImageView
    }

    let titleLabel = UILabel()

    func configureTitleLabel() -> UILabel {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: self.traitCollection)
        titleLabel.text = "Presented Content"
        // DARK MODE ADOPTION: Changed from .black to a semantic color:
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }

    let backgroundImageView = UIImageView()

    func configureBackgroundImageView() -> UIImageView {
        backgroundImageView.image = #imageLiteral(resourceName: "photo")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }

    let blurView = UIVisualEffectView()

    func configureBlurView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
        blurView.effect = blurEffect
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }

    let vibrancyView = UIVisualEffectView()

    func configureVibrancyView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
        // DARK MODE ADOPTION: Changed to use a specific iOS 13 vibrancy style:
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        vibrancyView.effect = vibrancyEffect
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        return vibrancyView
    }

    let vibrantLabel = UILabel()

    func configureVibrantLabel() -> UILabel {
        vibrantLabel.translatesAutoresizingMaskIntoConstraints = false
        vibrantLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: self.traitCollection)
        vibrantLabel.text = "Vibrant Label"
        return vibrantLabel
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 2),
            starImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 70),
            starImageView.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: starImageView.bottomAnchor, multiplier: 2),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            vibrancyView.topAnchor.constraint(equalTo: blurView.topAnchor),
            vibrancyView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            vibrancyView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            vibrantLabel.topAnchor.constraint(equalTo: vibrancyView.layoutMarginsGuide.topAnchor),
            vibrantLabel.leadingAnchor.constraint(equalTo: vibrancyView.layoutMarginsGuide.leadingAnchor)
            ])
    }
    
}
