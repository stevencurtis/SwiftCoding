//
//  DataTaskDelegateViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DataTaskDelegateViewController: UIViewController, URLSessionDataDelegate {
    
    var session : URLSession? = nil
    var activityIndicator: UIActivityIndicatorView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dataTaskDelegateAction(_ sender: UIButton) {
        if let url = url {
            dataTaskDownload(url)
        }
    }
    
    func dataTaskDownload(_ url: URL) {
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator?.color = .black
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
        activityIndicator?.startAnimating()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session?.dataTask(with: url)
        
        task?.resume()
    }

    
    // This delegate method may be called more than once, and each call provides only data received since the previous call. The app is responsible for accumulating this data if needed.
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print ("Receiving data")
    }
    
}
