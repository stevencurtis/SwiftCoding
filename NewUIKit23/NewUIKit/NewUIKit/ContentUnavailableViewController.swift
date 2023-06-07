//
//  ContentUnavailableViewController.swift
//  NewUIKit
//
//  Created by Steven Curtis on 07/06/2023.
//

import UIKit

class ContentUnavailableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var config = UIContentUnavailableConfiguration.empty()
        config.image = UIImage(systemName: "star.fill")
        config.text = "No"
        config.secondaryText = "Your favorite translations will appear here."
        contentUnavailableConfiguration = config
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
