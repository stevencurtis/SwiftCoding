//
//  ViewController.swift
//  AlamofireNetworking
//
//  Created by Steven Curtis on 17/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = Session.default
        let router: APIRouter = JSONPlaceHolderAPIAction.getToDo(id: 8)
        downloadData(NetworkManager(session: session, router: router), completion: {response in
            switch response {
            case .success(let data):
                let decoder = JSONDecoder.init()
                let user = try! decoder.decode(ToDoModel.self, from: data)
                print (user)
            case.failure:
                print ("error")
                // the error should be handled here
            }
        })
    }
    
    func downloadData(
        _ networkManager: NetworkManagerProtocol,
        completion: @escaping (Result<Data, AFError>) -> Void) {
        networkManager.get(completionBlock: { response in
            completion(response.result)
        })
    }
}
