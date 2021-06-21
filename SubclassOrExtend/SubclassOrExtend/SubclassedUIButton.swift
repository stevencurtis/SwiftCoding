//
//  SubclassedUIButton.swift
//  SubclassOrExtend
//
//  Created by Steven Curtis on 03/12/2020.
//

import UIKit

@IBDesignable class SubclassedUIButton: UIButton {
    // the left-hand side subview that will be added to the button
    let lhsView = UIView()
    
    // cannot be called cornerRadius since the Extension has a property with that name!
    @IBInspectable var crnrRadius: CGFloat = 0 {
        // use property observers to run code when this is changed
        didSet {
            layer.cornerRadius = crnrRadius
            layer.masksToBounds = crnrRadius > 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // run the customize version to set the colours and the UIView
        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // run the customize version to set the colours and the UIView
        customize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Whenever the frame changes, run the customize function
        customize()
    }
    
    @IBInspectable var lhsBackgroundColor: UIColor?
    
    func customize() {
        
        // confine subviews to the bounds of the view
        self.clipsToBounds = true
        
        // set the 
        layer.cornerRadius = crnrRadius
        
        // set the backgroundColor of the Button
        backgroundColor = UIColor.green
        
        // set the edge inserts for the title, so it is centered on the right-hand side of the UIButton
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        
        // set the backgroundColor of the left-hand side. this defaults to green
        lhsView.backgroundColor = lhsBackgroundColor ?? UIColor.green
        
        // create the frame of the UIView
        lhsView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        // add the left-hand side to the UIButton
        addSubview(lhsView)
    }
}

