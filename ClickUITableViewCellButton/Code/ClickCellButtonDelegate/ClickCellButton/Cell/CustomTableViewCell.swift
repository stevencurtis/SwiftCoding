//
//  CustomTableViewCell.swift
//  ClickCellButton
//
//  Created by Steven Curtis on 06/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var delegate: ClickDelegate?
    var cellIndex: IndexPath?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    @IBAction func buttonAction(_ sender: UIButton)
    {
        delegate?.clicked(cellIndex!.row)
    }
}

