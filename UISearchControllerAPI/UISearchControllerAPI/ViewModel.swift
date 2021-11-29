//
//  ViewModel.swift
//  BasicSearchController
//
//  Created by Steven Curtis on 15/11/2021.
//

import Foundation

class ViewModel: NSObject {
    var data: [String] = ["1", "2", "3"]
    
    var dataChanged: (() -> ())?
    
    var apiCalledCount: Int = 0
    
    /// Cancel the previous request, and then perform the API call after a delay
    func makeSearch(with term: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(search(_:)), with: term, afterDelay: TimeInterval(1.0))
    }

    @objc func search(_ text: String) {
        apiCalledCount += 1
        print("Searched \(apiCalledCount) times")
        data = ["1", "2", "3"]
        dataChanged?()
    }
}
