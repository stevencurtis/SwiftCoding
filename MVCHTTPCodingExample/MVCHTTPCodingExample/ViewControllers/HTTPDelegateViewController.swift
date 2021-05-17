//
//  HTTPDelegateViewController.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class HTTPDelegateViewController: UIViewController {
    
    var dataDownloaded = 0 {
        didSet {
            DispatchQueue.main.async(execute: {  [weak self] () -> Void in
                guard let self = self else {return}
                self.dataDownloadedLabel.text = "Array objects downloaded : \(self.dataDownloaded)"
                }
            )
        }
    }
    
    @IBOutlet weak var dataDownloadedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func downloadAPIAction(_ sender: UIButton) {
        DelegationHTTPManager.shared.delegate = self
        DelegationHTTPManager.shared.get(urlString: baseUrl + "/breaches")
    }
}

extension HTTPDelegateViewController : DelegationHTTPDelegate {
    func didDownloadBreaches(_ data: Data) {
        dataDownloaded += data.count
    }
}
