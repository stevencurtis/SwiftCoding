//
//  DataTaskDelegate.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DataTaskDelegate: NSObject, URLSessionDataDelegate {
    
    var callback: (() -> ())? = nil
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print ("Receiving data")
        callback!()
    }
    
}
