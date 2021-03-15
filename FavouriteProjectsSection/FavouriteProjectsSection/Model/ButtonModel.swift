//
//  ButtonModel.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import Foundation

public struct ButtonModel {
    public let title: String?
    public let accessibilityIdentifier: String?
    public let action: () -> Void
    public let icon: String?
    
    public init(
        title: String? = nil,
        accessibilityIdentifier: String? = nil,
        action: @escaping () -> Void,
        icon: String? = nil
    ) {
        self.title = title
        self.accessibilityIdentifier = accessibilityIdentifier
        self.action = action
        self.icon = icon
    }
}
