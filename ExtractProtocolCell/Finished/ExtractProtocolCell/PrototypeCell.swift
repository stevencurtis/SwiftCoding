//
//  PrototypeCell.swift
//  ExtractProtocolCell
//
//  Created by Steven Curtis on 07/04/2023.
//

import UIKit

class PrototypeCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
}
