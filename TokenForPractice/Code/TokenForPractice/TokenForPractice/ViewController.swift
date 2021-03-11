//
//  ViewController.swift
//  TokenForPractice
//
//  Created by Steven Curtis on 10/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The initial consumerKey and consumerSecret are hard-coded
    let consumerKey = "key"
    let consumerSecret = "secret"
    
    var oAuthRequestKey: OAuthRequestKey?
    var oAuthRequestSecret: OAuthRequestSecret?
    
    typealias OAuthRequestKey = String
    typealias OAuthRequestSecret = String
    
    var oAuthAccessKey: OAuthAccessKey?
    var oAuthAccessSecret: OAuthAccessSecret?
    
    typealias OAuthAccessKey = String
    typealias OAuthAccessSecret = String

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestToken({
            self.requestAccessToken({
                self.makeAuthenticatedCalls { val in
                    print (val as Any)
                }
            })
        })
    }
    
    // These calls are authenticated, and potentially return data from an OAuth endpoint
    func makeAuthenticatedCalls(_ completion: @escaping (NSString?)->()) {
        let cc = (key: consumerKey, secret: consumerSecret)
        guard let oAuthAccessKey = oAuthAccessKey, let oAuthAccessSecret = oAuthAccessSecret, let url = URL(string: apiEndpoint)  else {return}
        let uc = (key: oAuthAccessKey, secret: oAuthAccessSecret)
        var req = URLRequest(url: url )
        req.oAuthSign(method: "POST", urlFormParameters: ["testkey":"testval", "testkeytwo":"testvaltwo"], consumerCredentials: cc, userCredentials: uc)
        
        let task = URLSession(configuration: .ephemeral).dataTask(with: req) { (data, response, error) in
            if let error = error {
                print(error)
            }
            else if let data = data {
                completion( NSString(data: data, encoding: String.Encoding.utf8.rawValue) )
            }
        }
        task.resume()
    }
    
    func requestAccessToken(_ completion: @escaping ()->()) {
        let cc = (key: consumerKey, secret: consumerSecret)
        guard let oAuthRequestKey = oAuthRequestKey, let oAuthRequestSecret = oAuthRequestSecret, let url = URL(string: accessTokenEndpoint) else {return}
        
        let uc = (key: oAuthRequestKey, secret: oAuthRequestSecret)
        var req = URLRequest(url: url )
        req.oAuthSign(method: "POST", urlFormParameters: [:], consumerCredentials: cc, userCredentials: uc)

        let task = URLSession(configuration: .ephemeral).dataTask(with: req) { (data, response, error) in
            if let error = error {
                print(error)
            }
            else if let data = data {
                (self.oAuthAccessKey, self.oAuthAccessSecret) = self.parseAccessToken(NSString(data: data, encoding: String.Encoding.utf8.rawValue))!
                completion()
            }
        }
        task.resume()
    }
    
    func requestToken(_ completion: @escaping ()->()) {
        // API and secret key is analogous to username and password
        let cc = (key: consumerKey, secret: consumerSecret)
        guard let url = URL(string: requestTokenEndpoint) else {
            return
        }
        var req = URLRequest(url: url )
        req.oAuthSign(method: "POST", consumerCredentials: cc)
        let task = URLSession(configuration: .ephemeral).dataTask(with: req) { (data, response, error) in
            if let error = error {
                print(error)
            }
            else if let data = data {
                (self.oAuthRequestKey, self.oAuthRequestSecret) = self.parseRequestToken(NSString(data: data, encoding: String.Encoding.utf8.rawValue))!
                completion()

            }
        }
        task.resume()
    }
    
    func parseAccessToken(_ responseString: NSString?) -> (OAuthAccessKey, OAuthAccessSecret)? {
        return nil
    }
    
    // An access token and access token secret are user-specific credentials used to authenticate OAuth 1.0a API requests. This is similar to specifying a particular account that a request is made on behalf of
    func parseRequestToken(_ responseString: NSString?) -> (OAuthRequestKey?,OAuthRequestSecret?)? {
        guard let responseString = responseString,
            let tokenStringComponents = responseString.components(separatedBy: "&").first,
            let tokenString = tokenStringComponents.components(separatedBy: "=").last,
            let tokenSecretStringComponents = responseString.components(separatedBy: "&").last,
            let tokenSecret = tokenSecretStringComponents.components(separatedBy: "=").last
            else {return nil}
        return (tokenString, tokenSecret)
    }
    
    func parseAccessToken(_ responseString: NSString?) -> (OAuthAccessKey?, OAuthAccessSecret?)? {
        guard let responseString = responseString,
            let tokenStringComponents = responseString.components(separatedBy: "&").first,
            let tokenString = tokenStringComponents.components(separatedBy: "=").last,
            let tokenSecretStringComponents = responseString.components(separatedBy: "&").last,
            let tokenSecret = tokenSecretStringComponents.components(separatedBy: "=").last
            else {return nil}
        return (tokenString, tokenSecret)
    }
    
    
}

