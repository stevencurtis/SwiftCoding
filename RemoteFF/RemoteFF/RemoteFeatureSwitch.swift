//
//  RemoteFeatureSwitch.swift
//  RemoteFF
//
//  Created by Steven Curtis on 17/07/2024.
//

import Foundation
import FirebaseRemoteConfigInternal

@propertyWrapper
public struct RemoteFeatureSwitch<T: Hashable> {
    public let key: String
    public let description: String
    private let defaultValue: T

    public var wrappedValue: T {
        let value = RemoteConfig.remoteConfig().configValue(forKey: key)
        switch T.self {
        case is Bool.Type:
            return (value.boolValue as? T) ?? defaultValue
        case is Int.Type:
            return (value.numberValue.intValue as? T) ?? defaultValue
        case is String.Type:
            return (value.stringValue as? T) ?? defaultValue
        default:
            return defaultValue
        }
    }

    public var projectedValue: RemoteFeatureSwitch<T> {
        return self
    }

    public init(key: String, description: String = "", defaultValue: T) {
        self.key = key
        self.description = description
        self.defaultValue = defaultValue
    }
}

extension RemoteFeatureSwitch where T == Bool {
    static func boolFeatureSwitch(key: String, description: String, defaultValue: Bool) -> RemoteFeatureSwitch<Bool> {
        return RemoteFeatureSwitch<Bool>(
            key: key,
            description: description,
            defaultValue: defaultValue
        )
    }
}
