//
//  StarImageView.swift
//  AnimateIconClick
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

@IBDesignable
class StarImageView: UIImageView {
    func animate() {
      UIView.animate(withDuration: 0.1, animations: {
        self.transform = self.transform.scaledBy(x: 0.3, y: 0.3)
        self.image = UIImage(named: "BlackStar")
      }, completion: { _ in
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: "RedStar")
        })
      })
    }
}
