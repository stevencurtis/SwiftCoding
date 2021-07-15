//
//  AnalyticsService.swift
//  ServiceOriented
//
//  Created by Steven Curtis on 29/03/2021.
//

import UIKit

class AnalyticsService: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if ALPHA
        //register with one id
        #else
        //Register with another one
        #endif
        //Analytics manager starttracking
        return true
    }
}
