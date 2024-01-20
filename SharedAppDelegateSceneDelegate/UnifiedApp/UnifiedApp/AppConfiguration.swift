//
//  AppConfiguration.swift
//  UnifiedApp
//
//  Created by Steven Curtis on 15/08/2023.
//

import UIKit

final class AppConfiguration {
    static func configureApp(for window: UIWindow?) {
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
