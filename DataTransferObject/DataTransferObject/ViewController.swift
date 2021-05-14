//
//  ViewController.swift
//  DataTransferObject
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit
import NetworkLibrary

struct ToDo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class ViewController: UIViewController {
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
    var anm: AnyNetworkManager<URLSession>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nm = NetworkManager(session: URLSession.shared)
        anm = AnyNetworkManager<URLSession>(manager: nm)
        
        anm!.fetch(url: url!, method: .get, completionBlock:{ res in
            switch res {
            case .success(let data):
                let decoder = JSONDecoder()
                let decoded = try? decoder.decode(ToDo.self, from: data)
                print ("succ \(decoded)")
            case .failure:
                print ("failure")
            }
        })
    }
}
