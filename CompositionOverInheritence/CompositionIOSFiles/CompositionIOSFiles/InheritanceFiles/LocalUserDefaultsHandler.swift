//
//  LocalUserDefaultsHandler.swift
//  CompositionIOSFiles
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class LocalUserDefaultsHandler: FileHandlerBaseClass {
    override func read(_ filename: String) -> String {
        return UserDefaults.standard.string(forKey: filename)!
    }
    override func write(_ filename: String, _ contents: String) {
        UserDefaults.standard.set(contents, forKey: filename)
    }
}
