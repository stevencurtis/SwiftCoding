//
//  ProfileTableViewCell.swift
//  ReusableUITableViewCellUIImage
//
//  Created by Steven Curtis on 13/06/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet private var profileView: ProfileView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(name: String) {
        profileView.configure(with: name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }
    
}
