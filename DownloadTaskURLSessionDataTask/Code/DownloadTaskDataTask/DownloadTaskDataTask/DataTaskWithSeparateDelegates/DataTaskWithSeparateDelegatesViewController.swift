//
//  DataTaskWithSeparateDelegatesViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DataTaskWithSeparateDelegatesViewController: UIViewController {

    var session: URLSession?
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dataTaskDelegateAction(_ sender: UIButton) {
        if let url = url {
            download(url)
        }
    }
    
    func download(_ url: URL) {
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
        activityIndicator!.startAnimating()
        activityIndicator!.color = .black
        let delegate = DataTaskDelegate()
        
        delegate.callback = {
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
            }
        }
        
        session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        
        let task = session?.dataTask(with: url)
        task?.resume()
    }
    

}
