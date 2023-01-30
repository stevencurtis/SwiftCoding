//
//  DetailViewModel.swift
//  LazyNavigationLink
//
//  Created by Steven Curtis on 09/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var text: String
    
    init(text: String) {
        self.text = text
    }
}
