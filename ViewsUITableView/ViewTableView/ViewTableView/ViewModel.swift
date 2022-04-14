//
//  ViewModel.swift
//  ViewTableView
//
//  Created by Steven Curtis on 18/12/2021.
//

import Foundation

class ViewModel {
    let dataSource: DataSource
    
    let data: [String] = ["Title", "1", "2"]
    
    init() {
        self.dataSource = DataSource(data: data)
    }
}
