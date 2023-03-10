//
//  ViewController.swift
//  CollectionViewFlowRotate
//
//  Created by Steven Curtis on 28/12/2020.
//

import UIKit

class ViewController: UIViewController{
    // lots of colours for our collectionview
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.systemPink]
    
    // the UICollectionView
    var collectionView: UICollectionView!

    // settings in viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the dataSource
        self.collectionView.dataSource = self
        // set the delegate
        self.collectionView.delegate = self
        // register the UICollectionViewCell
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "subclassedcell")
        // bounce when we reach the end of the contentview
        self.collectionView.alwaysBounceVertical = true
        // set the background color of the UICollectionView
        self.collectionView.backgroundColor = .white
    }
    
    override func loadView() {
        // set the layout as the CustomLayout
        let layout = CustomLayout()
        // Set the frame of the UICollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the whole view as the collectionview
        self.view = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    // a delegate function to be run when the UICollectionView is written
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print the information tot he console
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // How many items are there in a section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // there are as many items as in the data array
        data.count
    }
    
    // return a cell for each and every UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // attempt to dequeueResuableCell as SubclassedCollectionViewCell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subclassedcell", for: indexPath) as? SubclassedCollectionViewCell {
            // data is from the data array
            let data = self.data[indexPath.item]
            // setup the cell with the colour
            cell.setupCell(colour: data)
            // return the cell
            return cell
        }
        // if we can't dequque then something has gone terribly wrong, so we can fatalcrash
        fatalError("Unable to dequeue subclassed cell")
    }
}

