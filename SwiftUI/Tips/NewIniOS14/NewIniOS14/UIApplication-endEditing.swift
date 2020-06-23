//
//  UIApplication-endEditing.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
