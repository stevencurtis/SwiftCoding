//
//  ViewController.swift
//  ReturnToMainThread
//
//  Created by Steven Curtis on 21/02/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button: UIButton?
    @IBOutlet var textView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressButton() {
        let urlString = "https://picsum.photos/5000/5000"
        self.downloadFile(from: URL(string: urlString)!)
    }
    
    private func downloadFile(from url: URL) {
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
            guard let location = location, error == nil else {
                print("Error downloading file: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            do {
                let data = try Data(contentsOf: location)
                DispatchQueue.main.async {
                    self.textView?.text = "Downloaded \(data)"
                }

            } catch {
                print("Error saving file: \(error.localizedDescription)")
            }
        }
        downloadTask.resume()
    }
}
