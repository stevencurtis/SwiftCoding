//
//  UserDataManagerMock.swift
//  Starling-Tech-TestTests
//
//  Created by Steven Curtis on 15/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import CombineURLSession


class UserDataManagerMock: UserDataManagerProtocol {
    func deleteToken() {
        token = ""
    }
    
    var token: String? = "TOKEN"
}
