//
//  BreachViewModel.swift
//  MVVMDemo
//
//  Created by Steven Curtis on 14/10/2020.
//

import Foundation

class BreachViewModel {
    
    var breaches = [BreachModel(title: "000webhost"), BreachModel(title: "126")]
    
    func fetchBreaches(completion: @escaping (Result<[BreachModel], Error>) -> Void) {
        completion(.success(breaches))
    }
}
