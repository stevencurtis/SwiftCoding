//
//  NotificationHTTPManager.swift
//  MVCThreeMethods
//
//  Created by Steven Curtis on 12/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class NotificationHTTPManager {
    static let shared: NotificationHTTPManager = NotificationHTTPManager()
    
    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(urlString: String) {
        guard let url = URL(string: urlString) else {

            let dict = ["error": nil] as [String : Any?]
            NotificationCenter.default.post(name: Notification.Name.notificationHTTPDidUpdateNotification, object: self, userInfo: dict as [AnyHashable : Any])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                let dict = ["error": "nil"] as [String : Any]
                NotificationCenter.default.post(name: Notification.Name.notificationHTTPDidUpdateNotification, object: self, userInfo: dict as [AnyHashable : Any])
                return
            }
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    let dict = ["error": "nil"] as [String : Any?]
                    NotificationCenter.default.post(name: Notification.Name.notificationHTTPDidUpdateNotification, object: self, userInfo: dict as [AnyHashable : Any])

                    return
            }
            let dict = ["sent": responseData.count] as [String : Any?]
            NotificationCenter.default.post(name: Notification.Name.notificationHTTPDidUpdateNotification, object: self, userInfo: dict as [AnyHashable : Any])
        }
        task.resume()
    }
}
