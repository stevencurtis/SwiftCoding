//
//  PlayerViewClass.swift
//  VideoUICollectionView
//
//  Created by Steven Curtis on 02/01/2021.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
    
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
