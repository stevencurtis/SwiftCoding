//
//  LocalFileHandler.swift
//  CompositionIOSFiles
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class LocalFileHandler: FileHandlerBaseClass {
    override func read(_ filename: String) -> String {
        let ddpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = ddpath.first!.appendingPathComponent(filename)
        
        var localFile = String()
        
        if let fnString = try? String(contentsOf: filename, encoding: String.Encoding.utf8)
        {
            localFile = fnString
        }
        return localFile
    }
    
    override func write(_ filename: String, _ contents: String) {
        let ddpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = ddpath.first!.appendingPathComponent(filename)
        do {
            try contents.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print ("\(error) Error")
        }
    }
}
