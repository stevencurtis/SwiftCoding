//
//  CustomBarButtonItem.swift
//  AnimateBarButton
//
//  Created by Steven Curtis on 03/12/2020.
//

import UIKit

class CustomBarButtonItem: UIBarButtonItem {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // use the image set on the barButtonItem
        let icon = self.image
        
        // set the iconSize
        let iconSize = CGRect(origin: .zero, size: icon!.size)
        
        // create a UIButton with the iconSeize
        let iconButton = UIButton(frame: iconSize)
        
        // setBackgroundImage for the UIButton
        iconButton.setBackgroundImage(icon, for: [])

        // the button goes into the right-hand side of the Navigation Bar
        self.customView = iconButton
        
        // the custom view starts off small
        self.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        // animate the custom view to the regular size
        UIView.animate(withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 10,
            options: .curveLinear,
            animations: {
                // restore the identity transform; so the button goes back to the original size
                self.customView!.transform = .identity
            },
            completion: nil
        )
    }
}
