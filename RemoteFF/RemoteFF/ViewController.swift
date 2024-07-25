//
//  ViewController.swift
//  RemoteFF
//
//  Created by Steven Curtis on 17/07/2024.
//

//import FirebaseRemoteConfigInternal
import UIKit

final class ViewController: UIViewController {
    var viewModel = ViewModel()

    @IBOutlet private var testLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Should be in the viewModel
//        let testValue = RemoteConfig.remoteConfig().configValue(forKey: "test").boolValue
//        if testValue {
//            testLabel.text = "value true"
//        } else {
//            testLabel.text = "value false"
//        }
//        print("Test Values: \(String(describing: testValue))")
        
        viewModel.updateHandler = { [weak self] testValue in
            DispatchQueue.main.async {
                self?.testLabel.text = testValue ? "value true" : "value false"
            }
        }
        
        viewModel.fetchFeatureFlag()
    }
}
