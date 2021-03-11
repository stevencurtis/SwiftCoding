//
//  ServiceManagerMock.swift
//  TestingInjectingServicesTests
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
@testable import TestingInjectingServices

public class ServiceManagerMock: ServiceManagerProtocol {
    public init() {}
    
    public func getServiceName() -> String {
        return "MockServiceManager"
    }
}
