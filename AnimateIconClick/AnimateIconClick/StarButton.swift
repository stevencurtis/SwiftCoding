//
//  StarButton.swift
//  AnimateIconClick
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class StarButton: UIButton {
    func animate() {
      UIView.animate(withDuration: 0.1, animations: {
        self.transform = self.transform.scaledBy(x: 0.3, y: 0.3)
        let image = UIImage(named: "BlackStar")
        self.setImage(image, for: .normal)
      }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
            let image = UIImage(named: "RedStar")
            self.setImage(image, for: .normal)
        })
      })
    }
}
