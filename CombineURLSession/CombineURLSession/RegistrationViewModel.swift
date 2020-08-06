//
//  RegisterViewModel.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 08/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine

protocol RegistrationViewModelProtocol {
    var userName: String { get set }
    var password: String { get set }
    var repeatPassword: String { get set }
    var validMatchPassword: AnyPublisher<Bool, Never> { get }
    var validLengthPassword: AnyPublisher<Bool, Never> { get }
    var validPassword: AnyPublisher<Bool, Never> { get }
    var shouldNav: AnyPublisher<Bool, Never> { get }
    func register()
}

class RegistrationViewModel<T: HTTPManagerProtocol>: RegistrationViewModelProtocol {
    
    // Published means we can add a publisher to either ivar
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    var httpmgr: T?
    var userdatamanager: UserDataManagerProtocol
    var publisher: AnyCancellable?
    var pst: Publishers.ReceiveOn<AnyPublisher<RegisterModel, Error>, DispatchQueue>?
    var shouldNav: AnyPublisher<Bool, Never> {
        shouldNavSubject.eraseToAnyPublisher()
    }
    private let shouldNavSubject = PassthroughSubject<Bool, Never>()

    
    init(networkManager: T, userdatamanager: UserDataManagerProtocol) {
        httpmgr = networkManager
        self.userdatamanager = userdatamanager
    }
    
    func register() {
        pst = httpmgr?.post(url: API.register.url!,
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
    
    // 26:11 on the Combine in Practice WWDC19 video, outdated API
//    var validatedPassword: CombineLatest<Published<String>, Published<String>, String?> {
//        return CombineLatest($password, $passwordAgain) { password, passwordAgain in
//            guard password == passwordAgain, password.count > 8 else { return nil }
//            return password
//        }
//    }
    
    var validLengthPassword: AnyPublisher<Bool, Never> {
        return $password.debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map{$0.count >= passwordLength ? true : false}
        .eraseToAnyPublisher()
    }

    // Publisher returns a Boolean that can nebver fail, enabled by .eraseToAnyPublisher()
    var validMatchPassword: AnyPublisher<Bool, Never> {
        return $password.combineLatest($repeatPassword) { (pw1, pw2)  in
            var isValid = false
            isValid = (pw1 == pw2)
            return isValid
            }.eraseToAnyPublisher()
    }
    
    var validPassword: AnyPublisher<Bool, Never> {
        return $password.combineLatest($repeatPassword) { (pw1, pw2)  in
            var isValid = false
            isValid = (pw1 == pw2) && pw2.count >= passwordLength
            return isValid
            }.eraseToAnyPublisher()
    }
    
    

}
