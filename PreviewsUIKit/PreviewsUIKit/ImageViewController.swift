//
//  ImageViewController.swift
//  PreviewsUIKit
//
//  Created by Steven Curtis on 19/11/2021.
//

import SwiftUI
import UIKit

// required to be final
final class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageViewController: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> ImageViewController {
      return ImageViewController()
  }

  func updateUIViewController(_ uiViewController: ImageViewController,
    context: Context) {
  }
}

struct ImageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ImageViewController()
    }
}
