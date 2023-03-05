//
//  ViewController.swift
//  FreezeUI
//
//  Created by Steven Curtis on 21/02/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func downloadFile(from url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            print("Error downloading file")
            return
        }
        // Save or otherwise deal with the downloaded file
        print(data)
    }
    
//    func downloadFile(from url: URL) {
//        let session = URLSession(configuration: .default)
//        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
//            guard let location = location, error == nil else {
//                print("Error downloading file: \(error?.localizedDescription ?? "unknown error")")
//                return
//            }
//
//            do {
//                let data = try Data(contentsOf: location)
//                // Save or otherwise deal with the downloaded file
//                print(data)
//            } catch {
//                print("Error saving file: \(error.localizedDescription)")
//            }
//        }
//        downloadTask.resume()
//    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = "https://picsum.photos/5000/5000"
        self.downloadFile(from: URL(string: urlString)!)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "press to download"
        return cell
    }
}
