//
//  SegueMVCMVVMViewController.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SegueMVVMViewController: UIViewController {

    var segueViewModel : SegueViewModelProtocol?
    
    public var serviceManager : ServiceManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labView = SegueMVVMView(frame: self.view.frame)
        segueViewModel = SegueMVVMViewModel(model: ServiceModel(serviceName: serviceManager?.getServiceName() ) )
        
        segueViewModel?.configure(labView)
        
        self.view.addSubview(labView)
        labView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
    }
    



}
