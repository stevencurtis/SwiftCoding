//
//  UITextField+Bindable.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

public protocol Bindable {
    associatedtype BindingType: Equatable
    func bind(with observable: Observable<BindingType>)
}

extension UITextField: Bindable, UITextFieldDelegate {
    public typealias BindingType = String
    private struct BinderHolder {
        static var _binder: Observable<BindingType>?
    }
    
    var binder: Observable<BindingType>? {
        get {
            return BinderHolder._binder
        }
        set(newValue) {
            BinderHolder._binder = newValue
        }
    }

    public func bind(with observable: Observable<BindingType>) {
        self.delegate = self
        binder = observable
        observable.observe(on: self, completion: { newText in
            // update text
            if self.text != newText {
                self.text = newText
            }
        })
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        binder?.value = (textField.text ?? "")
    }
}
