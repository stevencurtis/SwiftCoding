//
//  HeadingTableViewCell.swift
//  ViewTableView
//
//  Created by Steven Curtis on 18/12/2021.
//

import UIKit

class HeadingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with title: String) {
        self.textLabel?.text = title
    }
}
