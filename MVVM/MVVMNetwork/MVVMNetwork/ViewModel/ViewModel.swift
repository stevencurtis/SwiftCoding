//
//  ViewModel.swift
//  MVVMNetwork
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

// no direct access is avaliable to the model

class BreachViewModel : BreachViewModelType {
    var breaches = [BreachModel]()
    
    init() {
        // add init for ClosureHTTPManager here, to allow it to be teestable in the future
    }
    
    func fetchData(completion: @escaping ([BreachModel]) -> Void) {
        ClosureHTTPManager.shared.get(urlString: baseUrl + breachesExtensionURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    self.breaches = try decoder.decode([BreachModel].self, from: dta)
                    completion(try decoder.decode([BreachModel].self, from: dta))
                } catch {
                    // deal with error from JSON decoding!
                }
            }            
        })
    }
    
    func numberItemsToDisplay() -> Int {
        return breaches.count
    }
    
    func configure (_ view: BreachView, number index: Int) {
        // set the name and data in the view
        view.nameLabel.text = breaches[index].name
    }
    
}


