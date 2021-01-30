//
//  ViewController.swift
//  CharlesExample
//
//  Created by Steven Curtis on 19/12/2020.
//

import UIKit
import NetworkLibrary

class ViewController: UIViewController {
    private var anyNetworkManager: AnyNetworkManager<URLSession>?
    private var loginButton = UIButton()
    private var missingButton = UIButton()

    private var stackView = UIStackView()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nm = NetworkManager(session: URLSession.shared)
        self.anyNetworkManager = AnyNetworkManager(manager: nm)
        
        loginButton.setTitle("Make call", for: .normal)
        loginButton.backgroundColor = .blue
        
        missingButton.setTitle("Make missing call", for: .normal)
        missingButton.backgroundColor = .blue
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        // add the stackview to the view
        self.view.addSubview(stackView)
        // add login button to the stackview
        stackView.addArrangedSubview(loginButton)
        
        stackView.addArrangedSubview(missingButton)
        
        // this code will take care of the layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        missingButton.translatesAutoresizingMaskIntoConstraints = false
        
        // setup constraints
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(makeLoginNetworkCall), for: .touchUpInside)
        missingButton.addTarget(self, action: #selector(makeMissingNetworkCall), for: .touchUpInside)
    }
    
    @objc func makeLoginNetworkCall() {
        let data: [String : Any] = ["email": "userName", "password": "password"]
        anyNetworkManager?.fetch(url: API.login.url, method: .post(body: data), completionBlock: { res in
            switch res {
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let jsonDict = jsonObject as? NSDictionary {
                        print (jsonDict)
                    }
                    if let jsonArray = jsonObject as? NSArray {
                        print (jsonArray)
                    }
                } catch {
                    // error handling
                }

            case .failure(let error):
                print (error)
            }
        })
    }
    
    
    @objc func makeMissingNetworkCall() {
        let data: [String : Any] = ["email": "userName", "password": "password"]
        anyNetworkManager?.fetch(url: API.missing.url, method: .post(body: data), completionBlock: { res in
            switch res {
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let jsonDict = jsonObject as? NSDictionary {
                        print (jsonDict)
                    }
                    if let jsonArray = jsonObject as? NSArray {
                        print (jsonArray)
                    }
                } catch {
                    // error handling
                }

            case .failure(let error):
                print (error)
            }
        })
    }



}

