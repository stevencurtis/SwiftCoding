//
//  ListResponse.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import OperationQueueDependentAPICalls


let listResponseStruct = ListUsersModel(page: 2, per_page: 6, total: 12, total_pages: 2, data: [UserDataModel(id: 7, email: "michael.lawson@reqres.in", first_name: "Michael", last_name: "Lawson", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/follettkyle/128.jpg"),
UserDataModel(id: 8, email: "lindsay.ferguson@reqres.in", first_name: "Lindsay", last_name: "Ferguson", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/araa3185/128.jpg"),
UserDataModel(id: 9, email: "tobias.funke@reqres.in", first_name: "Tobias", last_name: "Funke", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/vivekprvr/128.jpg"),
UserDataModel(id: 10, email: "byron.fields@reqres.in", first_name: "Byron", last_name: "Fields", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/russoedu/128.jpg"),
UserDataModel(id: 11, email: "george.edwards@reqres.in", first_name: "George", last_name: "Edwards", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/mrmoiree/128.jpg"),
UserDataModel(id: 12, email: "rachel.howell@reqres.in", first_name: "Rachel", last_name: "Howell", avatar: "https://s3.amazonaws.com/uifaces/faces/twitter/hebertialmeida/128.jpg")
], ad: AdModel(company: "StatusCode Weekly", url: "http://statuscode.org/", text: "A weekly newsletter focusing on software development, infrastructure, the server, performance, and the stack end of things."))

let listResponse =
"""
{
    "page": 2,
    "per_page": 6,
    "total": 12,
    "total_pages": 2,
    "data": [
        {
            "id": 7,
            "email": "michael.lawson@reqres.in",
            "first_name": "Michael",
            "last_name": "Lawson",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/follettkyle/128.jpg"
        },
        {
            "id": 8,
            "email": "lindsay.ferguson@reqres.in",
            "first_name": "Lindsay",
            "last_name": "Ferguson",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/araa3185/128.jpg"
        },
        {
            "id": 9,
            "email": "tobias.funke@reqres.in",
            "first_name": "Tobias",
            "last_name": "Funke",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/vivekprvr/128.jpg"
        },
        {
            "id": 10,
            "email": "byron.fields@reqres.in",
            "first_name": "Byron",
            "last_name": "Fields",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/russoedu/128.jpg"
        },
        {
            "id": 11,
            "email": "george.edwards@reqres.in",
            "first_name": "George",
            "last_name": "Edwards",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/mrmoiree/128.jpg"
        },
        {
            "id": 12,
            "email": "rachel.howell@reqres.in",
            "first_name": "Rachel",
            "last_name": "Howell",
            "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/hebertialmeida/128.jpg"
        }
    ],
    "ad": {
        "company": "StatusCode Weekly",
        "url": "http://statuscode.org/",
        "text": "A weekly newsletter focusing on software development, infrastructure, the server, performance, and the stack end of things."
    }
}
""".data(using: .utf8)
