//
//  ViewModel.swift
//  ForeverScroll
//
//  Created by Steven Curtis on 19/03/2021.
//

import Foundation

protocol ViewModelProtocol{
    var data: [String] { get }
    var closure: (() -> Void)? { set get }
    func fetch()
}

class ViewModel: ViewModelProtocol {
    var data: [String] = []
    var closure: (() -> Void)?
    init() {}
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let nums: [String] = (self.data.count...self.data.count + 15).map{$0.description}
            print(nums)
            self.data.append(contentsOf: nums)
            DispatchQueue.main.async {
                self.closure?()
            }
        }
        )
    }
}
