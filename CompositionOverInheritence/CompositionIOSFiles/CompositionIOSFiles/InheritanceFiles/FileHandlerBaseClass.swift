//
//  FileHandlerBaseClass.swift
//  CompositionIOSFiles
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class FileHandlerBaseClass {
    // these properties cannot easily be placed in a subclass, meaning they are pushed up the hierarchy
    // however, they run the risk of being used in the wrong subclasses
    // particularly if we add Core Data & SQL file handlers that conform to the base class
    func read(_ filename: String) -> String {
        return ""
    }
    func write(_ filename: String, _ contents: String) {
    }
    
    func allFiles() -> [String] {
        return []
    }
    
    func allKeysValues() -> [String: String] {
        return [:]
    }
    
}
