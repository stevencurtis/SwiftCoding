//
//  ViewModel.swift
//  ViewsThreads
//
//  Created by Steven Curtis on 02/12/2021.
//

import Foundation

final class ViewModel {
    var dictionary: NSDictionary = [:] {
        didSet {
            DispatchQueue.main.async {
                self.dictionarySet?(self.dictionary)
            }
        }
    }
    var dictionarySet: ((NSDictionary) -> ())?
    
    var array: NSArray = []
    init() { }
    let urlString = "https://jsonplaceholder.typicode.com/todos/8"
    
    func getUsers() {
        let urlSession = URLSession.shared
        urlSession.dataTask(with: URL(string: urlString)!, completionHandler: { data, _, _ in
            let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: [])
            if let jsonDict = jsonObject as? NSDictionary {
                self.dictionary = jsonDict
            }
            if let jsonArray = jsonObject as? NSArray {
                print (jsonArray)
            }
        }).resume()
    }
}
