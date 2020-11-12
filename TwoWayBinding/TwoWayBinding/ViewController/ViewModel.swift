//
//  ViewModel.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 04/11/2020.
//

import Foundation

class ViewModel {
    var firstName: Observable<String> = Observable("First")
    var secondName: Observable<String> = Observable("Second")
    var thirdName: MakeBindable<String> = MakeBindable("Third")

    init() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.firstName.value = "First Changed"
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.secondName.value = "Second Changed"
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.thirdName.update(with: "Third Changed")
        })
        
    }
    
    func getName() -> String? {
        return firstName.value
    }
}
