//
//  AppsCompositionalLayout.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 25/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    private enum Constants {
        static let inset = CGFloat(20)
    }

    private var button = UIButton(type: .system)
    private let topLine = UIView()
    private let titleLabel = UILabel(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    
    var titleButtonAction: (() -> ())?
    
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
        if let buttonModel = content.button {
            button.setTitle(buttonModel.title, for: .normal)
            titleButtonAction = buttonModel.action
            button.addTarget(self, action: #selector(getButtonTapped(_:)), for: .touchUpInside)
            button.isHidden = false
        } else {
            button.isHidden = true
        }
        titleLabel.text = content.title
    }
    
    func sharedinit() {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .light)
        button.titleLabel?.textColor = .link
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .right
        button.isUserInteractionEnabled = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        
        titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        stackView.axis = .vertical
        
        addSubview(topLine)
        topLine.backgroundColor = .systemGray5
        topLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @IBAction func getButtonTapped(_ sender: UIButton){
      titleButtonAction?()
    }

}
