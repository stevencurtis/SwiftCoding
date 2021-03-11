//
//  Constants.swift
//  CoreDataToDo
//
//  Created by Steven Curtis on 13/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let entityName = "TaskEntity"
    static let entityNameAttribute = "task"
    static let entityCompletedattribute = "completed"
    static let alertStoryBoard = "Alerts"
    
    struct alerts {
        static let mainAlert = "AlertViewController"
        static let grayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        static let bgColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    }
}
