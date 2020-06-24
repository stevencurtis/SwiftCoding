//
//  ViewController.swift
//  HorizontalCollection
//
//  Created by Steven Curtis on 06/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dta = ["a","kldfkaunfd","jello|", "fourth", "5","a","kldfkaunfd","jello|",
               "fourth", "5", "a","kldfkaunfd","jello|", "fourth",
               "5","a","kldfkaunfd","jello|", "fourth", "5",
               "a","kldfkaunfd","jello|", "fourth", "5", "a","kldfkaunfd",
               "jello|", "fourth", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
       
        let frame = self.view.frame
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .lightGray
        self.view.backgroundColor = .lightGray
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dta.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.txtLab.text = dta[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {}
