//
//  QuizManagerMultiton.swift
//  sociologygcse
//
//  Created by Steven Curtis on 23/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
protocol DMBuilderProtocol {
    static func createDataManager<T: URLSessionProtocol>(with urlsession: T) -> DataManagerProtocol
}

extension DataManagerBuilder : DMBuilderProtocol {
}

class DataManagerBuilder {
    private static var sharedDataManager: DataManagerProtocol?
    private init() {}
    
        static func createDataManager<T>(with urlsession: T) -> DataManagerProtocol where T : URLSessionProtocol {
        
        if sharedDataManager == nil {
            let manager = HTTPManager(session: URLSession.shared)
            sharedDataManager = DataManager(manager)
        }
        return sharedDataManager!
    }
}

