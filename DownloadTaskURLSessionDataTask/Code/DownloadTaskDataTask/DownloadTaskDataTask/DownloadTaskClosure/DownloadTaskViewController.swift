//
//  DownloadTaskViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DownloadTaskViewController: UIViewController {
    
    var session: URLSession? = nil
    var activityIndicator: UIActivityIndicatorView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func DownloadTaskAction(_ sender: UIButton) {
        if let url = url {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            self.view.addSubview(activityIndicator!)
            activityIndicator?.color = .black
            self.view.bringSubviewToFront(activityIndicator!)
            activityIndicator?.startAnimating()
            downloadTask(url)
        }
    }
    
    func downloadTask(_ url: URL) {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let task = session?.downloadTask(with: url) {[weak self] url, urlresponse, error in
            print (urlresponse!)
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
            }
        }
        task?.resume()
    }
    
}
