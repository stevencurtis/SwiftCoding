//
//  ControlsViewModel.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 11/11/2020.
//

import Foundation

class ControlsViewModel {

    var sliderValue: MakeBindable<Float> = MakeBindable(2.5)
    var nameValue: MakeBindable<String> = MakeBindable("test")
    
    var segmentedValue: MakeBindable<Int> = MakeBindable(0)
    
    var buttonEnabled: MakeBindable<Bool> = MakeBindable(true)
    
    var switchValue: MakeBindable<Bool> = MakeBindable(true)
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//            self.nameValue.update(with: "AAA")
//        })
    }
}
