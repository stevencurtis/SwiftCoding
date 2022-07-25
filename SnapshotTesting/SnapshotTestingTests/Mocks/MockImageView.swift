//
//  MockImageView.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class MockImageView: UIImageView {
    var finished: (()->())?
    override var image: UIImage? {
        didSet {
            super.image = image
            if let finished = finished {
                finished()
            }
        }
    }
}
