//
//  ViewController.swift
//  AnimateButtonLabel
//
//  Created by Steven Curtis on 01/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedButton: UIButton!
    @IBOutlet weak var animatedButtonWithImage: UIButton!
    @IBOutlet weak var animatedButtonImageStop: UIButton!
    
    @IBOutlet weak var roundedAnimatedButton: UIButton!
    @IBOutlet weak var roundedAnimatedImageButton: UIButton!
    
    @IBOutlet weak var animatedButtonSubclass: AnimatedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animatedButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        animatedButtonWithImage.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        animatedButtonImageStop.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        roundedAnimatedButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        roundedAnimatedImageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        animatedButtonSubclass.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // confine the subviews to the bounds of the animatedButton
        animatedButton.clipsToBounds = true
        // create a CABasicAnimation for the x-position animation
        let buttonAnimation = CABasicAnimation(keyPath: "position.x")
        // begin the animation straight away
        buttonAnimation.beginTime = 0.0
        // this animation will last 1.5 seconds
        buttonAnimation.duration = 1.5
        // a property representing the x value where the titleLabel will scroll from
        let buttonRHS: Double = Double(((animatedButton.titleLabel?.frame.maxX)! + (animatedButton.titleLabel?.frame.width)!))
        // a property representing the x value where the titleLabel will scroll to
        let buttonLHS: Double = Double(((animatedButton.titleLabel?.frame.minX)! - ((animatedButton.titleLabel?.frame.width)!)))
        // set the from value of the animation
        buttonAnimation.fromValue = NSNumber(value: buttonRHS)
        // set the to value of the animation
        buttonAnimation.toValue = NSNumber(value: buttonLHS )
        // repeat the animation forever
        buttonAnimation.repeatCount = .infinity
        // add the animation to the UIButton's titleLabel
        self.animatedButton.titleLabel!.layer.add(buttonAnimation, forKey: "basic")
        
        animateButtonWithImage()
        
        // confine the subviews to the bounds of the animatedButton
        roundedAnimatedButton.layer.masksToBounds = false
        // set the corner radius. width / 2 gives this a circular look
        roundedAnimatedButton.layer.cornerRadius = roundedAnimatedButton.frame.width/2
        // center the text in the text
        roundedAnimatedButton.titleLabel?.textAlignment = .center
        // add the animation through this function
        animateRoundedButton()

        
        animateRoundedButtonStop()

        
        // round the corners
        roundedAnimatedImageButton.layer.cornerRadius = roundedAnimatedButton.frame.width/2
        // center the text
        roundedAnimatedImageButton.titleLabel?.textAlignment = .center

        // do not automatically setup autolayout
        img.translatesAutoresizingMaskIntoConstraints = false
        // add the img to the roundedAnimatedImageButton
        self.roundedAnimatedImageButton.addSubview(img)

        // set up the constraints
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: roundedAnimatedImageButton.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: roundedAnimatedImageButton.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 20),
            img.heightAnchor.constraint(equalToConstant: 20)
        ])

        // animate the round button withan image
        animateRoundedButtonImage()
    }
    
    let img = UIImageView(image: UIImage(systemName: "doc.fill"))

    
    func animateRoundedButtonImage() {
        // confine the subviews to the bounds of this view
        roundedAnimatedImageButton.clipsToBounds = true

        // a property to represent the midpoint of the button
        let buttonMid: Double = Double(((roundedAnimatedImageButton.titleLabel?.frame.midX)!))
        // a property to represent the left-hand side of the button to scroll just out of the view of the user
        let buttonLHS: Double = Double(((roundedAnimatedImageButton.titleLabel?.frame.minX)! - ((roundedAnimatedImageButton.titleLabel?.frame.width)!)))

        // The animation to move the textLabel from the right-hand side to the middle
        let labelFromRHSAnimation = CABasicAnimation(keyPath: "position.x")
        // a property to represent the right-hand side of a button
        let buttonRHS: Double = Double(((roundedAnimatedImageButton.titleLabel?.frame.maxX)! + (roundedAnimatedImageButton.titleLabel?.frame.width)!)) + 15.0

        // set the from value of the animation
        labelFromRHSAnimation.fromValue = NSNumber(value: buttonRHS)
        // set the to value of the animation
        labelFromRHSAnimation.toValue = NSNumber(value: buttonMid)
        // begin this animation after 5 seconds
        labelFromRHSAnimation.beginTime = 5.0
        // this animation will last 2 seconds
        labelFromRHSAnimation.duration = 2
        
        // move from mid to lhs (happens first)
        let labelFromMidAnimation = CABasicAnimation(keyPath: "position.x")
        // set the from value of the animation
        labelFromMidAnimation.fromValue = NSNumber(value: buttonMid)
        // set the to value of the animation
        labelFromMidAnimation.toValue = NSNumber(value: buttonLHS)
        // begin this animation after 5 seconds
        labelFromMidAnimation.beginTime = 1.0
        // this animation will last 2 seconds
        labelFromMidAnimation.duration = 2

        // an animation to hide the label after the from mid animation
        let labelStayOffAnimation = CABasicAnimation(keyPath: "hidden")
        // set the from value of the animation
        labelStayOffAnimation.fromValue = false
        // set the to value of the animation
        labelStayOffAnimation.toValue = true
        // begin this animation after 3 seconds
        labelStayOffAnimation.beginTime = 3.0
        // The animation is near-instantaneous here
        labelStayOffAnimation.duration = 0.01
        // the label will stay hidden moving forwards in time
        labelStayOffAnimation.fillMode = .forwards
        
        // show the label after the image will perform other animations
        let labelAppearBackAnimation = CABasicAnimation(keyPath: "hidden")
        // set the from value of the animation
        labelAppearBackAnimation.fromValue = true
        // set the to value of the animation
        labelAppearBackAnimation.toValue = false
        // begin this animation after 5 seconds
        labelAppearBackAnimation.beginTime = 5.0
        // The animation is near-instantaneous here
        labelAppearBackAnimation.duration = 0.01
        // the label will stay hidden moving forwards in time
        labelAppearBackAnimation.fillMode = .forwards
        
        // create an animation group to hold the animations for the label
        let labelGroupAnimations = CAAnimationGroup()
        // populate the animations array
        labelGroupAnimations.animations = [labelFromRHSAnimation, labelFromMidAnimation, labelStayOffAnimation, labelAppearBackAnimation]
        // since the duration of the group is longer than the constituent animation, the textLabel will stay in the middle of the UIButton in the remaining time
        labelGroupAnimations.duration = 8
        // repeat the animation indefinately
        labelGroupAnimations.repeatCount = .infinity
        // begin the group of animations immediately
        labelGroupAnimations.beginTime = CACurrentMediaTime()
        
        // a property to represent the center point of the titleLabel
        let imageMid: Double = Double(((roundedAnimatedImageButton.titleLabel?.frame.midX)!))
        // a property to represnt the left hand side of the button, where the image will scroll to
        let imageLHS: Double = Double(((roundedAnimatedImageButton.titleLabel?.frame.minX)! - ((roundedAnimatedImageButton.titleLabel?.frame.width)!)))
        
        // an animation to hide the image when it is not due to be viewed by the user
        let imageHideAnimation = CABasicAnimation(keyPath: "hidden")
        // set the from value of the animation
        imageHideAnimation.fromValue = 1
        // set the to value of the animation
        imageHideAnimation.toValue = 0
        // begin this animation immediately
        imageHideAnimation.beginTime = 0
        // the image will be hidden for 8 seconds
        imageHideAnimation.duration = 8.0
        
        // an animation to move the image from the middle of the screen to the left-hand side
        let imageFromMidAnimation = CABasicAnimation(keyPath: "position.x")
        // set the from value of the animation
        imageFromMidAnimation.fromValue = NSNumber(value: imageMid)
        // set the to value of the animation
        imageFromMidAnimation.toValue = NSNumber(value: imageLHS)
        // the animation will begin in 6 seconds
        imageFromMidAnimation.beginTime = 6.0
        // the animation lasts 2 seconds
        imageFromMidAnimation.duration = 2
        
        let imageFromRHSAnimation = CABasicAnimation(keyPath: "position.x")
        // a property to represent the right-hand side of the screen
        let imageRHS: Double = buttonRHS
        // set the from value of the animation
        imageFromRHSAnimation.fromValue = NSNumber(value: imageRHS)
        // set the to value of the animation
        imageFromRHSAnimation.toValue = NSNumber(value: imageMid)
        // the animation will begin in 3 seconds
        imageFromRHSAnimation.beginTime = 3.0
        // the animation lasts 2 seconds
        imageFromRHSAnimation.duration = 2

        let imageGroupAnimations = CAAnimationGroup()
        // add the animations to the animations group
        imageGroupAnimations.animations = [imageHideAnimation, imageFromRHSAnimation, imageFromMidAnimation]
        // the duration is longer than the constituent animations, so the image pauses in the middle of the screen
        imageGroupAnimations.duration = 8.0
        // repeat the animation group indefinitely
        imageGroupAnimations.repeatCount = .infinity
        // the animation group begins immediately
        imageGroupAnimations.beginTime = 0.0

        self.roundedAnimatedImageButton.titleLabel!.layer.add(labelGroupAnimations, forKey: "basicRep")
        // add the animation to the img (which has already been added to the UIButton class)
        img.layer.add(imageGroupAnimations, forKey: "imageRep")
    }
    
    func animateRoundedButtonStop() {
        roundedAnimatedButton.clipsToBounds = true
                
        let labelAnimationInitial = CABasicAnimation(keyPath: "position.x")
        labelAnimationInitial.beginTime = CACurrentMediaTime() + 2.0
        labelAnimationInitial.duration = 1.5
        let buttonMid: Double = Double(((roundedAnimatedButton.titleLabel?.frame.midX)!))
        let buttonLHS: Double = Double(((roundedAnimatedButton.titleLabel?.frame.minX)! - ((roundedAnimatedButton.titleLabel?.frame.width)!)))
        labelAnimationInitial.fromValue = NSNumber(value: buttonMid)
        labelAnimationInitial.toValue = NSNumber(value: buttonLHS )

        let labelFromRHSAnimation = CABasicAnimation(keyPath: "position.x")
        let buttonRHS: Double = Double(((roundedAnimatedButton.titleLabel?.frame.maxX)! + (roundedAnimatedButton.titleLabel?.frame.width)!)) + 15.0
        labelFromRHSAnimation.fromValue = NSNumber(value: buttonRHS)
        labelFromRHSAnimation.toValue = NSNumber(value: buttonMid)
        labelFromRHSAnimation.beginTime = 3.0
        labelFromRHSAnimation.duration = 2
        
        // move from mid to lhs
        let labelFromMidAnimation = CABasicAnimation(keyPath: "position.x")
        labelFromMidAnimation.fromValue = NSNumber(value: buttonMid)
        labelFromMidAnimation.toValue = NSNumber(value: buttonLHS)
        labelFromMidAnimation.beginTime = 1.0
        labelFromMidAnimation.duration = 2
        
        let labelGroupAnimations = CAAnimationGroup()
        labelGroupAnimations.animations = [labelFromRHSAnimation, labelFromMidAnimation]
        // animations is a group of CABasicAnimation
        labelGroupAnimations.duration = 6 // will stay in the middle for 6 - 2 -2 seconds
        labelGroupAnimations.repeatCount = .infinity
        self.roundedAnimatedButton.titleLabel!.layer.add(labelGroupAnimations, forKey: "basicRep")
    }
    
    func animateRoundedButton() {
        // confine the subviews to the bounds of this view
        animatedButtonImageStop.clipsToBounds = true
                
        // create a CABasicAnimation for the x-position animation, which will move the titleLabel from the midpoint to the left
        let labelAnimationInitial = CABasicAnimation(keyPath: "position.x")
        // begin the animation after 2 seconds. CACurrentMediaTime is the current absolute time
        labelAnimationInitial.beginTime = CACurrentMediaTime() + 2.0
        // this animation will last 1.5 seconds
        labelAnimationInitial.duration = 1.5
        // a property representing the mid start point of the titleLabel
        let buttonMid: Double = Double(((animatedButtonImageStop.titleLabel?.frame.midX)!))
        // a property representing the x value where the titleLabel will scroll to on the left-hand side
        let buttonLHS: Double = Double(((animatedButtonImageStop.titleLabel?.frame.minX)! - ((animatedButtonImageStop.titleLabel?.frame.width)!)))
        // set the from value of the animation
        labelAnimationInitial.fromValue = NSNumber(value: buttonMid)
        // set the to value of the animations
        labelAnimationInitial.toValue = NSNumber(value: buttonLHS )

        // create a CABasicAnimation for the x-position animation, which will move the titleLabel from the right to the midpoint
        let labelFromRHSAnimation = CABasicAnimation(keyPath: "position.x")
        // a property representing the x value where the titleLabel will scroll from on the right-hand side. The + 15.0 is an offset
        let buttonRHS: Double = Double(((animatedButtonImageStop.titleLabel?.frame.maxX)! + (animatedButtonImageStop.titleLabel?.frame.width)!)) + 15.0
        // set the from value of the animation
        labelFromRHSAnimation.fromValue = NSNumber(value: buttonRHS)
        // set the to value of the animations
        labelFromRHSAnimation.toValue = NSNumber(value: buttonMid)
        // begin the animation after 3 seconds
        labelFromRHSAnimation.beginTime = 3.0
        // this animation will last 2 seconds
        labelFromRHSAnimation.duration = 2
        
        // move from mid to lhs
        let labelFromMidAnimation = CABasicAnimation(keyPath: "position.x")
        // set the from value of the animation
        labelFromMidAnimation.fromValue = NSNumber(value: buttonMid)
        // set the to value of the animations
        labelFromMidAnimation.toValue = NSNumber(value: buttonLHS)
        // begin the animation after 1 second
        labelFromMidAnimation.beginTime = 1.0
        // this animation will last 2 seconds
        labelFromMidAnimation.duration = 2
        
        // The animation group for moving the textLabel
        let labelGroupAnimations = CAAnimationGroup()
        // Set the animations for this CAAnimationGroup()
        labelGroupAnimations.animations = [labelFromRHSAnimation, labelFromMidAnimation]
        // the duration - which is longer than the consitiuent animations, so the textLabel will stay in the middle
        // of the screen for the remaining time
        labelGroupAnimations.duration = 6
        // This animation will repeat indefinitely
        labelGroupAnimations.repeatCount = .infinity
        // animation is added to the titleLabel
        self.animatedButtonImageStop.titleLabel!.layer.add(labelGroupAnimations, forKey: "basicRep")
    }
    
    func animateButtonWithImage() {
        // confine the subviews to the bounds of this view
        animatedButtonWithImage.clipsToBounds = true
        // create a CABasicAnimation for the x-position animation
        let labelAnimation = CABasicAnimation(keyPath: "position.x")
        // begin the animation straight away
        labelAnimation.beginTime = 0.0
        // this animation will last 1.5 seconds
        labelAnimation.duration = 1.5
        // a property representing the x value where the titleLabel will scroll from
        let buttonRHS: Double = Double(((animatedButtonWithImage.titleLabel?.frame.maxX)! + (animatedButtonWithImage.titleLabel?.frame.width)!))
        // a property representing the x value where the titleLabel will scroll to
        let buttonLHS: Double = Double(((animatedButtonWithImage.titleLabel?.frame.minX)! - ((animatedButtonWithImage.titleLabel?.frame.width)!)))
        // set the from value of the animation
        labelAnimation.fromValue = NSNumber(value: buttonRHS)
        // set the to value of the animation
        labelAnimation.toValue = NSNumber(value: buttonLHS)
        // repeat the animation forever
        labelAnimation.repeatCount = .infinity
        
        // create a CABasicAnimation for the x-position animation
        let imageAnimation = CABasicAnimation(keyPath: "position.x")
        // some padding as the imageview and the titleLabel would overlap each other is not
        let imageViewPadding: Double = Double((animatedButtonWithImage.imageView?.frame.width)!) + Double((animatedButtonWithImage.titleLabel?.frame.midX)!)
        // begin the animation straight away
        imageAnimation.beginTime = 0.0
        // this animation will last 1.5 seconds
        imageAnimation.duration = 1.5
        // a property representing the x value where the imageView will scroll from
        let imageRHS: Double = buttonRHS - imageViewPadding
        // a property representing the x value where the imageView will scroll to
        let imageLHS: Double = buttonLHS - imageViewPadding
        // set the from value of the animation
        imageAnimation.fromValue = NSNumber(value: imageRHS)
        // set the to value of the animations
        imageAnimation.toValue = NSNumber(value: imageLHS)
        // repeat the animation forever
        imageAnimation.repeatCount = .infinity

        // add the animation to the UIButton's imageView layer
        self.animatedButtonWithImage.imageView!.layer.add(imageAnimation, forKey: "basic")
        // add the animation to the UIButton's titleLabel layer
        self.animatedButtonWithImage.titleLabel!.layer.add(labelAnimation, forKey: "basic")
    }
    
    @objc private func buttonAction() {
        print ("Button Pressed")
    }


}


