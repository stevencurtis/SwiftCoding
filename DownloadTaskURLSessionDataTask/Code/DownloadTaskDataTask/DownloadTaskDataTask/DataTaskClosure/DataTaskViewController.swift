//
//  DataTaskViewController.swift
//  DownloadTaskDataTask
//
//  Created by Steven Curtis on 08/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class DataTaskViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView? = nil
    
    var session: URLSession? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func DataTaskButtonAction(_ sender: UIButton) {
        if let url = url {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator?.color = .black
            activityIndicator?.startAnimating()
            self.view.addSubview(activityIndicator!)
            self.view.bringSubviewToFront(activityIndicator!)
            dataTask(url)
        }
    }
    
    func dataTask(_ url: URL) {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let task = session?.dataTask(with: url) {[weak self] data, urlresponse, error in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
            }
        }
        task?.resume()
    }
    

}
