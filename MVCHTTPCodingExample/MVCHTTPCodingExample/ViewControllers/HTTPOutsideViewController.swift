//
//  HTTPOutsideViewController.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class HTTPOutsideViewController: UIViewController {

    // By definition this approach CANNOT work
    
    @IBOutlet weak var dataDownloadedLabel: UILabel!
    var dataDownloaded = 0 {
        didSet {
            DispatchQueue.main.async(execute: {  [weak self] () -> Void in
                guard let self = self else {return}
                self.dataDownloadedLabel.text = "Array objects downloaded : \(self.dataDownloaded)"
                }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func makeAPICall(_ sender: UIButton) {
        let httpManager = TightlyCoupledHTTPManager()
        httpManager.get(urlString: baseUrl + breachesExtensionURL)
        dataDownloaded += httpManager.data.count
    }

    
}
