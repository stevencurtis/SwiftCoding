//
//  MyTableViewCell.swift
//  OutletsShouldBePrivate
//
//  Created by Steven Curtis on 23/06/2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet private var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func configure(text: String) {
//        myLabel.text = text
//    }
    
}
