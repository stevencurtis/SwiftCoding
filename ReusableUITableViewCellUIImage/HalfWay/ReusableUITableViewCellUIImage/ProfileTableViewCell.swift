//
//  ProfileTableViewCell.swift
//  ReusableUITableViewCellUIImage
//
//  Created by Steven Curtis on 13/06/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak private var circularImageView: CircularView!
    @IBOutlet weak private var chevronImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        circularImageView.image = UIImage(named: "man")
        let chevron = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        chevronImageView.image = chevron
        chevronImageView.tintColor = .black
    }
    
    
    func setup(name: String) {
        nameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }
    
}
