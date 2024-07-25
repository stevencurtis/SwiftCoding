//
//  AppDelegate.swift
//  RemoteFF
//
//  Created by Steven Curtis on 17/07/2024.
//

import FirebaseCore
import UIKit
import FirebaseRemoteConfigInternal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        fetchFeatureFlags()
        return true
    }
    
    func fetchFeatureFlags() {
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0  // During testing
        // settings.isDeveloperModeEnabled = true  // Depreciated but useful for immediate effects
        config.configSettings = settings
        // Configure minimum fetch interval
        config.fetchAndActivate { status, error in
            if let error = error {
                print("Error during Remote Config fetch: \(error.localizedDescription)")
            } else {
                print("Remote Config fetched and activated \(status)")
                
                let testValue = RemoteConfig.remoteConfig().configValue(forKey: "test").boolValue
                     print("Test Value: \(String(describing: testValue))")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

