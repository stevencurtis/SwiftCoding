//
//  Colors.swift
//  DarkMode
//
//  Created by Steven Curtis on 20/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit


// A Dynamic color
let myColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    if traitCollection.userInterfaceStyle == .dark {
        return .black
    } else {
        return .white
    }
}
