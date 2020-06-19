//
//  NetworkManager.swift
//  AlamofireNetworking
//
//  Created by Steven Curtis on 17/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func get(completionBlock: @escaping (AFDataResponse<Data>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    var session: Session?
    var router: APIRouter?
    
    required init(session: Session, router: APIRouter) {
        self.session = session
        self.router = router
    }
    
    func get(completionBlock: @escaping (AFDataResponse<Data>) -> Void) {
        session?.request(router!).responseData(completionHandler: {data in
            completionBlock(data)
        })
    }
}


