//
//  HTTPNotificationViewController.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class HTTPNotificationViewController: UIViewController {

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
        NotificationCenter.default.addObserver(self, selector: #selector( notificationReceived(withNotification:) ), name: Notification.Name.notificationHTTPDidUpdateNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func notificationReceived (withNotification notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let prog = userInfo["sent"] as? Int {
                dataDownloaded += prog
            }
        }
    }
    
    @IBAction func downloadAPIAction(_ sender: UIButton) {
        NotificationHTTPManager.shared.get(urlString: "https://haveibeenpwned.com/api/v2" + "/breaches")
    }
    
}

extension Notification.Name {
    static let notificationHTTPDidUpdateNotification = Notification.Name("NotificationHTTPDidUpdateNotification")
}

