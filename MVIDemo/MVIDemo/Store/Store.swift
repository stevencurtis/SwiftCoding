//
//  Store.swift
//  MVIDemo
//
//  Created by Steven Curtis on 01/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

var mainStore: BehaviorRelay<State> = BehaviorRelay<State>(value: InitialState())
