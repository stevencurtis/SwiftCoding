//
//  ViewModel.swift
//  RemoteFF
//
//  Created by Steven Curtis on 17/07/2024.
//

import Foundation
import FirebaseRemoteConfigInternal

final class ViewModel {
    var updateHandler: ((Bool) -> Void)?
    var testValue: Bool = false {
        didSet {
            updateHandler?(testValue)
        }
    }
    
    func fetchFeatureFlag() {
        print("remote: \(Features.isNewFeatureEnabled)")
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 
        config.fetchAndActivate { [weak self] status, error in
            if let error = error {
                print("Error fetching config: \(error.localizedDescription)")
            } else {
                print("Config fetched and activated")
                self?.testValue = config.configValue(forKey: "test").boolValue
                print("remote fetchAndActivate: \(Features.isNewFeatureEnabled)")

            }
        }
    }
}
