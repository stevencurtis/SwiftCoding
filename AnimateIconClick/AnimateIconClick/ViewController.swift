//
//  ViewController.swift
//  AnimateIconClick
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var separateStarImage: StarImageView!
    @IBOutlet weak var starButton: StarButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleStarTap(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        starImage.isUserInteractionEnabled = true
        starImage.addGestureRecognizer(tapGestureRecognizer)
        
        let separateTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSeparateStarImageTap(tapGestureRecognizer:)))
        separateTapGestureRecognizer.numberOfTapsRequired = 1
        separateStarImage.isUserInteractionEnabled = true
        separateStarImage.addGestureRecognizer(separateTapGestureRecognizer)
        
        starButton.addTarget(self, action: #selector(handleStarButtonTap(_:)), for: .touchUpInside)
    }
    
    @objc private func handleStarButtonTap(_ sender: UIButton) {
        starButton.animate()
    }

    @objc private func handleStarTap(tapGestureRecognizer: UITapGestureRecognizer) {
        animate()
    }
    
    @objc private func handleSeparateStarImageTap(tapGestureRecognizer: UITapGestureRecognizer) {
        separateStarImage.animate()
    }

    private func animate() {
      UIView.animate(withDuration: 0.1, animations: {
        self.starImage.transform = self.starImage.transform.scaledBy(x: 0.3, y: 0.3)
        self.starImage.image = UIImage(named: "BlackStar")
      }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
            self.starImage.transform = CGAffineTransform.identity
            self.starImage.image = UIImage(named: "RedStar")

        })
      })
    }
    
}

