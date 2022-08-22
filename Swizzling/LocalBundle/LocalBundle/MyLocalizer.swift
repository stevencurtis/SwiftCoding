//
//  Extension - localizedStringForKey.swift
//  LocalBundle
//
//  Created by Steven Curtis on 01/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

let bundleName = "Bundle.bundle"

class MyLocalizer: NSObject {
    class func swizzleMainBundle() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            if let path = Bundle.main.path(forResource: bundleName, ofType: nil), let bundle = Bundle(path: path) {
                return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
            }
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    if let origMethod: Method = class_getInstanceMethod(cls, originalSelector), let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) {
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
}
