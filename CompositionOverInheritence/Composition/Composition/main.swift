//
//  main.swift
//  Composition
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

protocol FileHandlerReadable {
    func read() -> String
}
protocol FileHandlerWritable {
    func write(_ value: String)
}

struct FileHandler: FileHandlerReadable, FileHandlerWritable {
    func read() -> String {
        return ""
    }
    
    func write(_ value: String) {
        print (value)
    }
}

//protocol FileHandlerType: FileHandlerReadable, FileHandlerWritable {
//}
//
//let handler: FileHandlerType = FileHandler()
//handler.read()
//handler.write("Hello World")

let handler: FileHandlerReadable & FileHandlerWritable = FileHandler()
handler.read()
handler.write("Hello World")

