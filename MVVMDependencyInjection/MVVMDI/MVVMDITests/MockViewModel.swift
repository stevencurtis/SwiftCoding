//
//  File.swift
//  MVVMDITests
//
//  Created by Steven Curtis on 14/10/2020.
//

import Foundation
@testable import MVVMDI
class MockViewModel: ViewModel {
    var dataRequestClosure: (()->())?
    override func getData() {
        dataRequestClosure!()
    }
}
