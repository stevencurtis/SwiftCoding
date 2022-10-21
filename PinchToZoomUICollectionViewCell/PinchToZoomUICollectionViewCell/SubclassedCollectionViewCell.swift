//
//  SubclassedCollectionViewCell.swift
//  UICollectionViewFlowLayoutSubclass
//
//  Created by Steven Curtis on 12/12/2020.
//

import UIKit

class SubclassedCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    // the hotel is lazyly instantiated in a UIImageView
    var hotelImageView: UIImageView = {
        var hotelView = UIImageView()
        hotelView.contentMode = .scaleAspectFill
        hotelView.clipsToBounds = true
        hotelView.isUserInteractionEnabled = true
        return hotelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set up the pinch gesture
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        // this class is the delegate
        pinch.delegate = self
        // add the gesture to hotelImageView
        self.hotelImageView.addGestureRecognizer(pinch)
        
        // add the imageview to the UICollectionView
        addSubview(hotelImageView)
        // we are taking care of the constraints
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        // pin the image to the whole collectionview
        hotelImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hotelImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        hotelImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        hotelImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isZooming = false
        
    @objc func pinch(sender:UIPinchGestureRecognizer) {
        // if the cell is faded, don't allow the user to pinch
        guard alpha == 1.0 else {return}
        
        if sender.state == .began {
            // calculate the image scale
            let currentScale = self.hotelImageView.frame.size.width / self.hotelImageView.bounds.size.width
            // calculate the image scale after the pinch
            let newScale = currentScale * sender.scale
            // if we are really zooming, set the boolean
            if newScale > 1 {
                self.isZooming = true
                // bring the cell to the front of the superview
                self.superview?.bringSubviewToFront(self)
            }
        }
        // continuous gesture
        else if sender.state == .changed {
            guard let view = sender.view else {return}
            // set the center of the gesture
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            // set the transformation
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            // set the current scale of the image
            let currentScale = self.hotelImageView.frame.size.width / self.hotelImageView.bounds.size.width
            // set the scale once the gesture is complete
            var newScale = currentScale * sender.scale
            // if the scale is to reduce the size of the cell
            if newScale < 1 {
                // set the cell back to the original point
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.hotelImageView.transform = transform
                // set the scale back to one
                sender.scale = 1
            } else {
                // make the transformation
                view.transform = transform
                // set the scale back to one
                sender.scale = 1
            }
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            // animate the pop back to the orginal place for the UIImageView
            UIView.animate(withDuration: 0.3, animations: {
                // set the transform
                self.hotelImageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                // we are no longer zooming
                self.isZooming = false
            })
        }
    }
    
    func setupCell(image: String) {
        // set the appropriate image
        if let image : UIImage = UIImage(named: image) {
            hotelImageView.image = image
        }
    }
    
    func updateCell(faded: Bool, animated: Bool = true) {
        // if you want the opacity animated
        if animated {
            // animate with the duration in seconds
            UIView.animate(withDuration: 0.2) {
                // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
                self.alpha = faded ? 0.1 : 1.0
            }
        } else {
            // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
            self.alpha = faded ? 0.1 : 1.0
        }
    }
}



