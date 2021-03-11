//
//  SegueMVCViewModel.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class SegueMVVMViewModel: SegueViewModelProtocol {
    init(model: ServiceModel? = nil) {
        if let model = model {
            serviceModel = model
        }
    }
    
    var serviceModel : ServiceModel?
    
    public func configure(_ lab: SegueMVVMView) {
        lab.titleLabel.text = serviceModel?.serviceName
    }
    
    
}
