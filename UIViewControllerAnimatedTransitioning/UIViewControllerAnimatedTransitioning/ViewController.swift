//
//  ViewController.swift
//  UIViewControllerAnimatedTransitioning
//
//  Created by Steven Curtis on 17/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // equivalent of a Fatal Error
    lazy var people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "Peeps.json")
    
    private var originalCellFrame : CGRect?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemGray
        collection.isScrollEnabled = true
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        self.view.addSubview(collectionView)
        setupConstraints()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "PersonCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // we need to have the original frame for the cell, in the superview co-ordinate system
        let layoutAttributes: UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        originalCellFrame = collectionView.convert(layoutAttributes.frame, to: collectionView.superview)
        
        self.performSegue(withIdentifier: "detail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = sender as? Int, (segue.identifier == "detail") {
            let detailVC = segue.destination as! DetailViewController
            detailVC.person = people[row]
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = min(self.collectionView.frame.width, self.collectionView.frame.height)
        return CGSize(
            width: width / 1.5,
            height: width / 1.5)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PersonCollectionViewCell {
            cell.imageView.image = UIImage(named: people[indexPath.row].image)
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}


extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = originalCellFrame else {
            return nil
        }
        
        switch operation {
        case .pop:
            return GrowAnimator(isPresenting: false, originFrame: frame)
        case .push:
            return GrowAnimator(isPresenting: true, originFrame: frame)
        case .none:
            return GrowAnimator(isPresenting: false, originFrame: frame)
        @unknown default:
            return nil
        }
    }
}
