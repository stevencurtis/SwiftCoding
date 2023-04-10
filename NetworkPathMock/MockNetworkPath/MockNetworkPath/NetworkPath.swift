//
//  NetworkPath.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import Network

public struct NetworkPath {
    public var status: NWPath.Status
    
    public init(status: NWPath.Status) {
        self.status = status
    }
}

extension NetworkPath {
    public init(rawValue: NWPath) {
        self.status = rawValue.status
    }
}

extension NetworkPath: Equatable {}
