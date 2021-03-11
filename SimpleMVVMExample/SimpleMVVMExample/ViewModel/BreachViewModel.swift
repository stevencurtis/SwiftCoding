//
//  DisplayViewModel.swift
//  SimpleMVVMExample
//
//  Created by Steven Curtis on 03/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class BreachViewModel {
    // MARK: - Initialization
    init(model: [BreachModel]? = nil) {
        if let inputModel = model {
            breaches = inputModel
        }
    }
    
    var breaches: [BreachModel] = [BreachModel(title: "000webhost"),BreachModel(title: "126")]
    
}

extension BreachViewModel {
    func fetchBreaches(completion: @escaping (Result<[BreachModel], Error>) -> Void) {
        completion(.success(breaches))
    }
}
