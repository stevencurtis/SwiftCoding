//
//  MockURLSession.swift
//  BasicHTTPManagerTests
//
//  Created by Steven Curtis on 07/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import AlamofireNetworking

class URLProtocolMock: URLProtocol {
    /// returns the mock response
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        
        do {
            // create a tuple with the handler
            let (response, data): (HTTPURLResponse, Data?) = try handler(request)
            
            // the client instance requires an instance of URLProtocol, CachedURLResponse and cacheStoragePolicy
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                // send the data to the client
                client?.urlProtocol(self, didLoad: data)
            }
            
            // notify the client that the request has finished
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // notify the client that there is an error
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // called when the request is either cancelled or completed
    }
}

