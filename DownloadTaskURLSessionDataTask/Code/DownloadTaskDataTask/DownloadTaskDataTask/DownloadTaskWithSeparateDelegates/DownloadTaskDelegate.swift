//
//  DownloadTaskDelegate.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DownloadTaskDelegate: NSObject, URLSessionDownloadDelegate {
    
    var callback : (() -> ())? = nil
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print ("finish")
        callback!()
    }
    
    
}
