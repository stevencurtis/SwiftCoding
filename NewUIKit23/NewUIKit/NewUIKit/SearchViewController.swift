//
//  SearchViewController.swift
//  NewUIKit
//
//  Created by Steven Curtis on 07/06/2023.
//

import UIKit

class SearchViewController: UIViewController {
    private var searchResults = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config: UIContentUnavailableConfiguration?
        if searchResults.isEmpty {
            config = .search()
        }
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
