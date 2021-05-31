//
//  SubclassedCollectionViewCell.swift
//  ProgrammaticUICollectionView
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class SubclassedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
