//
//  MyTableViewCell.swift
//  ClickOnTableView
//
//  Created by Steven Curtis on 21/10/2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with tag: Int) {
        self.tag = tag
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(selected))
        self.addGestureRecognizer(tap)
    }
    
    @objc func selected() {
        print("\(self.tag)")
    }
}
