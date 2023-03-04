//
//  ViewController.swift
//  LayersPerformance
//
//  Created by Steven Curtis on 03/12/2020.
//

import UIKit
// for the video player!
import AVFoundation

class ViewController: UIViewController {
        
    // a container for the emitter
    @IBOutlet weak var emitterContainerView: UIView!
    
    // a container for the CATextLayer
    @IBOutlet weak var textContainerView: UIView!

    // a container for the CATransformLayer
    @IBOutlet weak var transformContainerView: UIView!
    
    // a container for the CAReplicatorLayer
    @IBOutlet weak var replicatorView: UIView!
    
    // the view that will contain the CAScrollLayer
    @IBOutlet weak var containerView: UIView!
    
    // The CAScrollLayer
    let scrollLayer: CAScrollLayer = CAScrollLayer()
    
    // The CADisplayLink
    var displayLink: CADisplayLink? = nil
    
    // a property to store the trams;
    var xTranslation: CGFloat = 0.0
    
    // update at 15 fps
    @objc func updateCADisplayLink() {
        // the new point to scroll to
        let newPoint = CGPoint(x: xTranslation, y: 0.0)
        scrollLayer.scroll(newPoint)
        xTranslation += 10.0
        // stop scrolling at the edge of the image
        // we can see that with the chosen placeholder image
        if xTranslation > 100.0 {
            // stor the CADisplayLink
            displayLink?.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }

    // The PlayerView
    @IBOutlet weak var playerView: PlayerView!
    // The AVPlayer
    var videoPlayer: AVPlayer? = nil

    func playVideo() {
        // path of the video in the bundle
        guard let path = Bundle.main.path(forResource: "AppInventorL1Setupemulator", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        // set the video player with the path
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        // play the video now!
        videoPlayer?.playImmediately(atRate: 1)
        // setup the AVPlayer as the player
        playerView.player = videoPlayer
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // access the layer
        let layer: CALayer = containerView.layer
        // set properties on the layer
        layer.cornerRadius = 20
        // more commonly used like this
        containerView.layer.cornerRadius = 20
        // set the image with the PlasholderImage from the asset catalog
        if let placeholderImage = UIImage(named: "PlaceholderImage") {
            // set the image size
            let imageSize = placeholderImage.size
            // a new CALayer
            let layer: CALayer = CALayer()
            // set the layer bounds
            layer.bounds = CGRect(x: 0.0, y: 0.0, width: imageSize.width, height: imageSize.height)
            // set the layer position
            layer.position = CGPoint(x: imageSize.width/2, y: imageSize.height/2)
            // layer contents is set to be the cgImage of the placeholder Image
            layer.contents = placeholderImage.cgImage
            // the bounds of the scrollLayer
            scrollLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
            // the initial position of the scrollLayer
            scrollLayer.position = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
            // the scrollLayer can scroll horizontally
            scrollLayer.scrollMode = CAScrollLayerScrollMode.horizontally
            // add the layer to the scrollLayer
            scrollLayer.addSublayer(layer)
            // add the scroll Layer to the view
            view.layer.addSublayer(scrollLayer)
        }
        
        // instantiate with the target and selector
        displayLink = CADisplayLink(target: self, selector: #selector(updateCADisplayLink))
        // this is 15 frames per second
        displayLink?.preferredFramesPerSecond = 15
        
        // register the displayLink with a runLoop. Common is the mode to use for timers
        displayLink?.add(to: .current, forMode: .common)
        
        
        let myTextLayer = CATextLayer()
        myTextLayer.string = "HI!"
        myTextLayer.backgroundColor = UIColor.blue.cgColor
        myTextLayer.foregroundColor = UIColor.cyan.cgColor
        myTextLayer.frame = textContainerView.bounds
        textContainerView.layer.addSublayer(myTextLayer)
        
        
        // The replicator layer
        let replicatorLayer = CAReplicatorLayer()
        // each square here is a CALayer
        let redSquare = CALayer()
        // set the background colour of the square
        redSquare.backgroundColor = UIColor.red.cgColor
        // each red square will be made up of thie CGRect
        redSquare.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        // there will be two red squares
        replicatorLayer.instanceCount = 2
        // the transform applied to the previous image, tx here is 110
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(110, 0, 0)
        // add the red square instances to the replicatorLayer
        replicatorLayer.addSublayer(redSquare)
        // add the replicatorLayer to the replicatorView
        replicatorView.layer.addSublayer(replicatorLayer)
        

        if let placeholderImage = UIImage(named: "PlaceholderImage") {
            let imageSize = placeholderImage.size
            // a new CALayer
            let layer: CALayer = CALayer()
            // set the layer bounds
            layer.bounds = CGRect(x: 0.0, y: 0.0, width: imageSize.width / 2, height: imageSize.height / 2)
            // set the layer position
            layer.position = CGPoint(x: imageSize.width/2, y: imageSize.height/2)
            // layer contents is set to be the cgImage of the placeholder Image
            layer.contents = placeholderImage.cgImage

            // create the transform layer
            let transformLayer = CATransformLayer()
            // set up a CATransform3DIdentity
            var perspective = CATransform3DIdentity
            // m34 = 1/z distance to projection plane (the 1/ez term)
            // http://en.wikipedia.org/wiki/3D_projection#Perspective_projection
            perspective.m34 = -1 / 500
            // transform to the perspective
            transformLayer.transform = perspective
            // set the position of the transform layer
            transformLayer.position = CGPoint(x: transformContainerView.bounds.midX, y: transformContainerView.bounds.midY)
            // add the layer
            transformLayer.addSublayer(layer)
            // add the transform layer as a subview
            transformContainerView.layer.addSublayer(transformLayer)
            // transform the layer
            layer.transform = CATransform3DMakeRotation(-0.5, 1, 0, 0)
        }
        
        let confettiViewEmitterLayer = CAEmitterLayer()
        // set the size of the emitter (where the particles originate)
        confettiViewEmitterLayer.emitterSize = CGSize(width: emitterContainerView.frame.width, height: 2)
        // set the shape to be a line, as opposed to be a rectange etc.
        confettiViewEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        // set the position of the emitter
        confettiViewEmitterLayer.emitterPosition = CGPoint(x: emitterContainerView.frame.width / 2, y: emitterContainerView.frame.height / 2)
        // set the cells that emit. In this case, a single cell
        confettiViewEmitterLayer.emitterCells = [generateConfettiEmitterCell()]
        // add the emitter layer as a subview
        emitterContainerView.layer.addSublayer(confettiViewEmitterLayer)
    }
    
    // this is a function that creates the CAEmitterCell
    private func generateConfettiEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        // set the colour to be black
        cell.color = UIColor.black.cgColor
        // set the contents to be the placeholder image
        cell.contents = UIImage(named: "PlaceholderImage")?.cgImage
        // number of items created per second
        cell.birthRate = 4.0
        // the lifetime of a cell in seconds
        cell.lifetime = 14.0
        // how much the lifetime of a cell can vary
        cell.lifetimeRange = 0
        // the scale factor applied to the call
        cell.scale = 0.1
        // the range in which the scale factor can vary
        cell.scaleRange = 0.25
        // the intial velocity of the cell
        cell.velocity = -CGFloat(100)
        // the amount by which the velocity can vary
        cell.velocityRange = 0
        // emission angle
        cell.emissionLongitude = CGFloat.pi
        // the cone around which emissions can occur
        cell.emissionRange = 0.5
        // the rotational velocity applied to the cell
        cell.spin = 3.5
        // the variance of spin over a cell's lifetime
        cell.spinRange = 1
        return cell
    }
        
}
