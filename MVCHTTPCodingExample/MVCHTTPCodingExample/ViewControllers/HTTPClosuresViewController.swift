//
//  HTTPClosuresViewController.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class HTTPClosuresViewController: UIViewController {

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
    
    @IBAction func APIButtonAction(_ sender: UIButton) {
        ClosureHTTPManager.shared.get(urlString: baseUrl + breachesExtensionURL, completionBlock: { [weak self] data in
            
            print ("thread", Thread.current)
            guard let self = self else { return }
            switch data {
            case .failure(let error):
                print(error)
                
            case .success(let dataret):
                self.dataDownloaded += dataret.count
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
