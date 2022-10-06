//
//  APIInViewControllerWithProtocol.swift
//  MVCArchitecture
//
//  Created by Steven Curtis on 14/05/2021.
//

import UIKit

class APIInViewControllerWithProtocol: UIViewController {
    @IBOutlet weak var dataDownloadedLabel: UILabel!
    
    var dataDownloaded = 0 {
        didSet {
            DispatchQueue.main.async(execute: {  [weak self] () -> Void in
                guard let self = self else {return}
                self.dataDownloadedLabel.text = "Data items downloaded: \(self.dataDownloaded)"
            }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func apiAction(_ sender: UIButton) {
        makeAPICall()
    }

    func makeAPICall() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: baseUrl + breachesExtensionURL)
        let task = session.dataTask(with: url!) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if let data = data{
                self.dataDownloaded += data.count
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "detail", sender: nil)
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DataViewProtocol {
            detailVC.data = dataDownloaded.description
        }
    }
}
