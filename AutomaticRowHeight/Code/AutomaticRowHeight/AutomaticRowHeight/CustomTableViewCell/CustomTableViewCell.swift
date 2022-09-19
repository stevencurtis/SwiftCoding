//
//  TableViewCell.swift
//  AutomaticRowHeight
//
//  Created by Steven Curtis on 11/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func button(_ sender: UIButton) {
        print ("Button")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
