//
//  MyTableViewCell.swift
//  UICollectionViewInUITableViewCell
//
//  Created by Steven Curtis on 12/11/2020.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    var dataRow: [UIColor] = []
    var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCellWith(row: [UIColor]) {
        self.dataRow = row
        self.collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 40, height: 44)
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(
            frame: self.frame,
            collectionViewLayout: layout)
        self.collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .blue
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyTableViewCell: UICollectionViewDelegate {}
extension MyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataRow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = dataRow[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }
}
