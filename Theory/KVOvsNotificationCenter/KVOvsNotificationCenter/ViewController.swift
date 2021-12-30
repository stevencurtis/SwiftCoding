//
//  ViewController.swift
//  KVOvsNotificationCenter
//
//  Created by Steven Curtis on 28/09/2020.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var sampleLabel: UILabel!
    
    @objc var objectToObserve: ViewModel?
    var observation: NSKeyValueObservation?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector( notificationReceived(withNotification:) ), name: NSNotification.Name(rawValue: "NamedataModelDidUpdateNotification"), object: nil)

        
        setupLabel()
        
        
        let observed = ViewModel()
        objectToObserve = observed
        
        observation = observe(
            \.objectToObserve!.myDate,
            options: [.old, .new]
        ) { object, change in
            print("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
        }
        
        observed.updateDate()
        

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
        observation?.invalidate()
    }
    
    func setupLabel() {
        sampleLabel.text = "A test label"
        sampleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    @objc func preferredContentSizeChanged(_ notification: Notification) {
        sampleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        let dict = ["sent": "data"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NamedataModelDidUpdateNotification"), object: self, userInfo: dict)
    }
    
    @objc func notificationReceived (withNotification notification: NSNotification) {
        if let prog = notification.userInfo?["sent"] as? String {
            print (prog)
        }
    }
}

