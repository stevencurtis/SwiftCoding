//
//  DownloadTaskWithSeparateDelegatesViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DownloadTaskWithSeparateDelegatesViewController: UIViewController {

    var session: URLSession? = nil
    var activityIndicator: UIActivityIndicatorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func downloadTaskAction(_ sender: UIButton) {
        if let url = url {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator?.color = .black
            self.view.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
            downloadTask(url)
        }
    }
    
    func downloadTask(_ url: URL) {
        let downloadTaskDelegate = DownloadTaskDelegate()
        downloadTaskDelegate.callback = {
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
            }
        }
        
        session = URLSession(configuration: .default, delegate: downloadTaskDelegate, delegateQueue: nil)
        let task = session!.downloadTask(with: url)
        task.resume()
    }
    
}
