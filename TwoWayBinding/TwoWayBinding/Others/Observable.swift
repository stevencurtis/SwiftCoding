//
//  Observable.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 04/11/2020.
//

import Foundation

public class Observable<ObservedType> {
    struct Observer<ObservedType> {
        weak var observer: AnyObject?
        let completion: (ObservedType) -> Void
    }

    private var observers: [Observer<ObservedType>]

    public var value: ObservedType? {
        didSet {
            if let _ = value {
                notifyObservers()
            }
        }
    }

    public init(_ value: ObservedType? = nil) {
        self.value = value
        observers = []
    }

    public func observe(on observer: AnyObject, completion: @escaping (ObservedType) -> Void) {
        observers.append(Observer(observer: observer, completion: completion))
        if let value = value {
            completion(value)
        }
    }

    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            if let value = value {
                DispatchQueue.main.async { observer.completion(value) }
            }
        }
    }
}
