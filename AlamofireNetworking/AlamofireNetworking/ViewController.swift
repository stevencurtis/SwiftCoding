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
        downladData(NetworkManager(session: session, router: router), completion: { response in
            switch response {
            case let .success(data):
                let decoder = JSONDecoder.init()
                let user = try! decoder.decode(ToDoModel.self, from: data)
                print (user)
            case let .failure(error):
                // the error should be handled here
                break
            }
        })
    }
    
    func downladData(
        _ networkManager: NetworkManagerProtocol,
        completion: @escaping (Result<Data, AFError>) -> Void) {
        networkManager.get(completionBlock: { response in
            completion(response.result)
        })
    }
}
