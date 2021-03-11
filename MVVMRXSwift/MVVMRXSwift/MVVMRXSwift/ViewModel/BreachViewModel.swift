//
//  DisplayViewModel.swift
//  SimpleMVVMExample
//
//  Created by Steven Curtis on 03/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import RxSwift

class BreachViewModel {
    // MARK: - Initialization
    init(model: [BreachModel]? = nil) {
        if let inputModel = model {
            breaches = inputModel
        }
    }
    var breaches = [BreachModel]()
}

extension BreachViewModel {
    func fetchBreachesRX() -> Observable<[BreachModel]> {
        return Observable.create{
            observer -> Disposable in
                HTTPManager.shared.get(urlString: baseUrl + breachesExtensionURL, completionBlock: { [weak self] result in
                    guard let self = self else {return}
                    switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let dta) :
                        let decoder = JSONDecoder()
                        do
                        {
                            self.breaches = try decoder.decode([BreachModel].self, from: dta)
                            observer.onNext(try decoder.decode([BreachModel].self, from: dta))
                            observer.onCompleted()
                        } catch {
                            // deal with error from JSON decoding if used in production
                        }
                    }
                })
            return Disposables.create()
        }
    }
    
    
    func fetchBreaches(completion: @escaping (Result<[BreachModel], Error>) -> Void) {
        HTTPManager.shared.get(urlString: baseUrl + breachesExtensionURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    self.breaches = try decoder.decode([BreachModel].self, from: dta)
                    completion(.success(try decoder.decode([BreachModel].self, from: dta)))
                } catch {
                    // deal with error from JSON decoding if used in production
                }
            }
        })
    }
}
