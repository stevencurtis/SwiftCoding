//
//  ViewController.swift
//  TypeErasure
//
//  Created by Steven Curtis on 21/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class AnyHTTPManager<U>: HTTPManagerProtocol {
    let session: U
    let closure: (URL, @escaping (Result<Data, Error>) -> Void) -> ()
    
    func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        closure(url, completionBlock)
    }
    
    init<T: HTTPManagerProtocol>(manager: T) {
        closure = manager.get
        session = manager.session as! U
    }
}

//class ViewController<U: HTTPManagerProtocol>: UIViewController{
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://httpbin.org/get")!

        // This is AnyHTTPManager
        httpManager?.get(url: url, completionBlock: { result in
            print ("use the returned data \(result)")
        })
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .red
    }
    
    var httpManager: AnyHTTPManager<URLSession>?
    
    init<T: HTTPManagerProtocol>(network: T) {
        self.httpManager = AnyHTTPManager(manager: network)
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
