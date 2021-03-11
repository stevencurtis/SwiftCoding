//
//  Delay.swift
//  TestAsync
//
//  Created by Steven Curtis on 31/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

func messageAfterDelay(message: String, time: Double, completion: @escaping (String)->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        completion (message)
    }
}
