//
//  CustomTableViewCell.swift
//  SnapshotViews
//
//  Created by Steven Curtis on 22/10/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var textLab: UILabel!
    
    func setUp() {
        print ("setup")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
