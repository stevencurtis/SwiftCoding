//
//  SubclassedTableViewCell.swift
//  InsetUITableViewCell
//
//  Created by Steven Curtis on 23/05/2021.
//

import UIKit

class SubclassedTableViewCell: UITableViewCell {
    var topInset: CGFloat = 0
    var leftInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var rightInset: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
}
