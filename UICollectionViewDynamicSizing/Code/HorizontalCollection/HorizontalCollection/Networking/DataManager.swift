//
//  DataManager.swift
//  HorizontalCollection
//
//  Created by Steven Curtis on 06/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import UIKit

protocol DataManagerProtocol {
    func fetchImageData(withURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) 
}

extension DataManager: DataManagerProtocol {}

class DataManager<T: HTTPManagerProtocol>  {
    var mgr: T?
    init  (_ manager: T) {
        mgr = manager
    }
    
    func fetchImageData(withURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        mgr?.get(url: URL(string: "aa")! ) { result in
            print ("fetchImageData")
            completion(.success(Data(count: 1)))
        }

    }

}

