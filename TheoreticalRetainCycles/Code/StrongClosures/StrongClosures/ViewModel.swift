//
//  ViewModel.swift
//  StrongClosures
//
//  Created by Steven Curtis on 10/02/2022.
//

import Foundation

class ViewModel {
    
    var articlesDidChange: ((String) -> Void)?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.articlesDidChange?("test")
        }
    }
}
