//
//  ViewModel.swift
//  KVOvsNotificationCenter
//
//  Created by Steven Curtis on 28/09/2020.
//

import Foundation

class ViewModel: NSObject {
    @objc dynamic var myDate = NSDate(timeIntervalSince1970: 0)
    func updateDate() {
        myDate = NSDate()
    }
}
