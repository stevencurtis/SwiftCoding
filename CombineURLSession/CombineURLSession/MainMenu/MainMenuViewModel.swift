//
//  MainMenuViewModel.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol MainMenuViewModelProtocol {
    func deleteToken()
}

class MainMenuViewModel: MainMenuViewModelProtocol {
    var userDataManager: UserDataManagerProtocol

    init(userDataManager: UserDataManagerProtocol) {
        self.userDataManager = userDataManager
    }
    
    func deleteToken() {
        userDataManager.deleteToken()
    }
}
