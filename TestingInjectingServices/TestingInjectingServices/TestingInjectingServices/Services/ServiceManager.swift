//
//  ServiceManager.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation



public class ServiceManager: ServiceManagerProtocol {
    public init() {}
    
    public func getServiceName() -> String {
        return "MainServiceManager"
    }
}
