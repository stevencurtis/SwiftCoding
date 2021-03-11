//
//  DownloadTaskDelegateViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DownloadTaskDelegateViewController: UIViewController, URLSessionDownloadDelegate {

    var session: URLSession? = nil
    var activityIndicator: UIActivityIndicatorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func downloadTask(_ url: URL) {
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        // cannot use a completion handler here
        let task = session?.downloadTask(with: url)
        task?.resume()
    }
    
    @IBAction func downloadTaskAction(_ sender: UIButton) {
        if let url = url {
            
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator?.color = .black
            self.view.addSubview(activityIndicator!)
            self.view.bringSubviewToFront(activityIndicator!)
            activityIndicator?.startAnimating()
            
            downloadTask(url)
        }
    }

    // Delegate methods
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            print (location)
            self.activityIndicator?.stopAnimating()
        }
    }

}
