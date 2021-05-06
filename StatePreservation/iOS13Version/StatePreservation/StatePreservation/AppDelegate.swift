//
//  AppDelegate.swift
//  StatePreservation
//
//  Created by Steven Curtis on 05/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            return true
        }
        
        func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
            return true
        }
        func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
            return true
        }
        
        func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
            return coder.decodeObject(forKey: "Restoration ID") as? UIViewController
            
        }
        func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
            UIApplication.shared.extendStateRestoration()
            DispatchQueue.main.async {
                UIApplication.shared.completeStateRestoration()
            }
        }
}

