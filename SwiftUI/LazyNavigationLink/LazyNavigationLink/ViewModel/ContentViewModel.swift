//
//  ContentViewModel.swift
//  LazyNavigationLink
//
//  Created by Steven Curtis on 09/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var animals = ["🦒", "🦮", "🐖" , "🦔", "🦓", "🦢", "🦋"]
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.animals = ["🦒", "🦒", "🦒" , "🦒", "🦒", "🦒", "🦒"]
        })
    }
}
