//
//  ViewController.swift
//  CollectionViewAsPageController
//
//  Created by Steven Curtis on 29/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
   
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nib = UINib(nibName: "PageCollectionViewCell", bundle: nil);
        self.collectionView.register(nib, forCellWithReuseIdentifier: "PageCell")
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 100))
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .white
        self.view.addSubview(pageControl)

        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    var count = 400
    
    func goNextPage() {
        currentPage += 1
        collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .right, animated: true)
        pageControl.currentPage = mod(currentPage, pageControl.numberOfPages)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath)
        if let pageCollectionViewCell = cell as? PageCollectionViewCell {
            pageCollectionViewCell.contentLabel.text = indexPath.row.description
            let content = cont[ mod(indexPath.row, cont.count) ]
            pageCollectionViewCell.setupVC(title: content.title, mainText: content.mainText, imageName: content.imageName, bgColor: content.bgColor, fgColor: content.fgColor) {
                self.goNextPage()
            }
        }
        return cell
    }
    
 vb
    
    var cont : [Content] = [
        Content(title: "Experiment", mainText: "In this App you must say the color of a word but not the name of the word. \nFor accuracy enable the microphone on the next screen.", imageName: "phone1", bgColor: color2, fgColor: color1),
        Content(title: "Learn", mainText: "Use your device microphone to say the color displayed.", imageName: "phone2", bgColor: color1, fgColor: color2),
        Content(title: "Fun", mainText: "This should be a fun exercise rather than seen as a test", imageName: "phone3", bgColor: color2, fgColor: color1),
        Content(title: "OK", mainText: "Get ready to start!", imageName: "phone4", bgColor: color1, fgColor: color2)
    ]

    var currentPage = 0
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(self.view.frame.width - 50 + 10)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        var newPage = Float(currentPage)
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? currentPage + 1 : currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
        }
        currentPage = Int(newPage)
        pageControl.currentPage = mod(currentPage, pageControl.numberOfPages)
        let point = CGPoint (x: CGFloat(newPage * pageWidth - 15), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    func mod(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height - 50)
    }

}

