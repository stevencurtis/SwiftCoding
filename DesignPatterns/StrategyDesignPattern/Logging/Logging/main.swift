//
//  main.swift
//  Logging
//
//  Created by Steven Curtis on 29/10/2020.
//

import Foundation

protocol LoggerProtocol {
    func log(_ message: String)
}

func use(logger: LoggerProtocol, with message: String) {
    logger.log(message)
}

struct PrintLogger: LoggerProtocol {
    func log(_ message: String) {
        print("The function \(#function) received \(message)")
    }
}

struct NSLogLogger: LoggerProtocol {
    func log(_ message: String) {
        NSLog ("Received %@", message)
    }
}

var printLogger = PrintLogger()
printLogger.log("Print Log")

var nsLogger = NSLogLogger()
nsLogger.log("print log using CSLog")

