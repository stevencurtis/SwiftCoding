//
//  CollapsableCell.swift
//  CollapsableTableViewCellProject
//
//  Created by Steven Curtis on 12/01/2024.
//

import UIKit

final class CollapsibleCell: UITableViewCell {
    private let counterLabel = UILabel()
    private let button = UIButton()
    private let stackView = UIStackView()
    var onButtonClicked: (() -> Void)?
    var count = 0
    {
        didSet {
            counterLabel.text = "Like count: \(count.description)"
        }
    }
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 8,
            trailing: 16
        )
        contentView.addSubview(stackView)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press to like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(buttonClicked),
            for: .touchUpInside
        )
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(expandableView)
        expandableView.addSubview(counterLabel)
        expandableView.isHidden = true
        contentView.addSubview(stackView)
        setConstraints()
    }

    @objc private func buttonClicked() {
        onButtonClicked?()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterLabel.topAnchor.constraint(equalTo: expandableView.topAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor)
        ])
    }
}
