//
//  StoredProperty.swift
//  StoredProperties
//
//  Created by Steven Curtis on 06/11/2020.
//

import Foundation

public class StoredProperty<T: Any> {
    private var propertyDictionary = [String:T]()
   
    func get(_ key: AnyObject) -> T? {
        return propertyDictionary["\(unsafeBitCast(key, to: Int.self))"] ?? nil
    }
   
    func set(_ key: AnyObject, value: T) {
        propertyDictionary["\(unsafeBitCast(key, to: Int.self))"] = value
    }
}
