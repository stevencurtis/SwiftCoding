//
//  ViewModel.swift
//  BasicSearchController
//
//  Created by Steven Curtis on 15/11/2021.
//

import Foundation

class ViewModel {
    var data: [String] = ["1", "2", "3"]
    
    var dataChanged: (() -> ())?

    func search(_ text: String) {
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text)) {
            data = ["1", "2", "3"]
            dataChanged?()
        } else {
            data = ["a", "b", "c"]
            dataChanged?()
        }
    }
}
