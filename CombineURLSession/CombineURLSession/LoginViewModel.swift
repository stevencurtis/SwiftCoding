//
//  LoginViewModel.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 09/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine

protocol LoginViewModelProtocol {
    var password: String { get set }
    var username: String { get set }
    var validLengthPassword: AnyPublisher<Bool, Never> { get }
    var validLengthUsername: AnyPublisher<Bool, Never> { get }
    var userValidation: AnyPublisher<Bool, Never> { get }
    func login()
    var shouldNav: AnyPublisher<Bool, Never> { get }
}

class LoginViewModel<T: HTTPManagerProtocol>: LoginViewModelProtocol {
    @Published var password: String = ""
    @Published var username: String = ""
    
    var httpmgr: T?
    var userdatamanager: UserDataManagerProtocol
    
    var publisher: AnyCancellable?
    var pst: Publishers.ReceiveOn<AnyPublisher<LoginModel, Error>, DispatchQueue>?
    
    var shouldNav: AnyPublisher<Bool, Never> {
        shouldNavSubject.eraseToAnyPublisher()
    }
    
    private let shouldNavSubject = PassthroughSubject<Bool, Never>()

    init(networkManager: T, userdatamanager: UserDataManagerProtocol) {
        httpmgr = networkManager
        self.userdatamanager = userdatamanager
    }
    
    func login() {
        pst = httpmgr?.post(url: API.login.url!,
                            headers: ["Content-Type": "application/x-www-form-urlencoded"],
                            data: "email=eve.holt@reqres.in&password=cityslicka".data(using: .utf8)!)
            .receive(on: DispatchQueue.main)
        
        publisher = pst!.sink(receiveCompletion: {
            switch $0 {
            case .finished: break
            case .failure(let error):
                // error should be handled here
                print (error)
            }
        }, receiveValue: {val in
            self.userdatamanager.token = val.token
            self.shouldNavSubject.send(true)
        })
    }
    
    var validLengthPassword: AnyPublisher<Bool, Never> {
        return $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{$0.count >= passwordLength ? true : false}
            .eraseToAnyPublisher()
    }
    
    var validLengthUsername: AnyPublisher<Bool, Never> {
        return $username.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{$0.count >= passwordLength ? true : false}
            .eraseToAnyPublisher()
    }
    
    var userValidation: AnyPublisher<Bool, Never> {
        validLengthUsername
            .zip(validLengthPassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}

