//
//  UserModelResponse.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 12/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import OperationQueueDependentAPICalls

let userModelResponseStruct = UserModel(data: UserDataModel(id: 7, email: "michael.lawson@reqres.in", first_name: "Michael", last_name: "Lawson", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/follettkyle/128.jpg"), ad: AdModel(company: "StatusCode Weekly", url: "http://statuscode.org/", text: "A weekly newsletter focusing on software development, infrastructure, the server, performance, and the stack end of things."))

let userModelResponse =
"""
{
    "data": {
        "id": 7,
        "email": "michael.lawson@reqres.in",
        "first_name": "Michael",
        "last_name": "Lawson",
        "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/follettkyle/128.jpg"
    },
    "ad": {
        "company": "StatusCode Weekly",
        "url": "http://statuscode.org/",
        "text": "A weekly newsletter focusing on software development, infrastructure, the server, performance, and the stack end of things."
    }
}
""".data(using: .utf8)
