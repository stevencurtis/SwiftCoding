//
//  SubclassedCollectionViewCell.swift
//  VideoUICollectionView
//
//  Created by Steven Curtis on 02/01/2021.
//

import UIKit
import AVFoundation

class SubclassedCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add the imageview to the UICollectionView
        addSubview(playerView)
        // we are taking care of the constraints
        playerView.translatesAutoresizingMaskIntoConstraints = false
        // pin the image to the whole collectionview - it is the same size as the container
        playerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // The PlayerView
    var playerView: PlayerView = {
        var player = PlayerView()
        player.backgroundColor = .lightGray
        return player
    }()
    
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
    
    func stopVideo() {
        playerView.player?.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This is the function to setup the CollectionViewCell
    func setupCell(image: String) {
        // set the appropriate image, if we can form a UIImage
//        if let image : UIImage = UIImage(named: image) {
//            hotelImageView.image = image
//        }
    }
}
