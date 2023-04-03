//
//  ViewController.swift
//  JSONBasics
//
//  Created by Steven Curtis on 28/03/2023.
//

import UIKit

class ViewController: UIViewController {
    let URL = "http://www.studeapps.com/JSONData/people.php"
    struct Person: Decodable {
        let name: String
        let age: Int
        let email: String
    }
    private var nameArray = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJSONFromURL()
    }

    private func getJSONFromURL() {
        guard let url = Foundation.URL(string: URL) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data,_,_ in
            guard let data else { return }
//            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
//                print(jsonObject)
//            }
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                if let av = jsonObject.value(forKey: "customers") {
                    print ("JSON data")
                    print(av)
                }
            }
            
        }).resume()
    }
}
