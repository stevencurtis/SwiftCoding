//
//  AppsCompositionalLayout.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 25/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let button = UIButton(type: .system)
    private let topLine = UIView()
    private let inset = CGFloat(20)
    
    var titleButtonAction : (() -> ())?

    private let outerStackView = UIStackView()
    private let labelStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedinit()
    }
    required init?(coder: NSCoder) {
        fatalError("Instantiation from Storyboard not supported")
    }
}

extension TitleSupplementaryView {
    
    public func configure(with content: HeaderContent) {
        titleLabel.text = content.title
        if let subtitle = content.subtitle {
            subtitleLabel.text = subtitle
        }
        
        if !content.visibleButton {
            self.button.isHidden = true
        } else {
            self.button.isHidden = false

        }
    }
    
    func sharedinit() {
        addSubview(outerStackView)
        outerStackView.axis = .horizontal
        outerStackView.alignment = .fill
        outerStackView.distribution = .equalSpacing
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            outerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            outerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset)
        ])
        
        labelStackView.axis = .vertical
        labelStackView.translatesAutoresizingMaskIntoConstraints = true
        outerStackView.addArrangedSubview(labelStackView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        
        labelStackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.numberOfLines = 1
        labelStackView.addArrangedSubview(subtitleLabel)
        
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .light)
        button.titleLabel?.textColor = .link
        self.button.addTarget(self, action: #selector(getButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        outerStackView.addArrangedSubview(button)
        
        addSubview(topLine)
        topLine.backgroundColor = .systemGray5
        topLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: topAnchor),
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            topLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @IBAction func getButtonTapped(_ sender: UIButton){
      titleButtonAction?()
    }
    
}
