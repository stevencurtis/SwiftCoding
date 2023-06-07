//
//  AnimationSymbolImagesViewController.swift
//  NewUIKit
//
//  Created by Steven Curtis on 07/06/2023.
//

import UIKit

class AnimationSymbolImagesViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(systemName: "speaker.wave.3")
        imageView.addSymbolEffect(.bounce)
        imageView.removeSymbolEffect(ofType: .variableColor)
    }
}
