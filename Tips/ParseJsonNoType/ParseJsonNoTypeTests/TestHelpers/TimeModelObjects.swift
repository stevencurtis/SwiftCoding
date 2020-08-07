//
//  TimeModelObjects.swift
//  ParseJsonNoTypeTests
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import ParseJsonNoType

let timeDateOne = Date(timeIntervalSince1970: 1547806529979)
let timeDateTwo = Date(timeIntervalSince1970: 1547806532250)

let testTime: [TimeModel] = [TimeModel(timeStamp: timeDateOne, uniqueKey: "policy:dev_pol_000000BansDm7Jjbj3k4R1IUJwrEe"), TimeModel(timeStamp: timeDateTwo, uniqueKey: "transaction:dev_tx_000000BansDm7JjbiFjqm6TTTFPdo")]
