//
//  Label+Model.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 17/02/2021.
//

import Foundation

extension Label {
    public final class Model {
        public typealias View = Label
        
        public var text: String?

        public init(
            text: String? = nil
        ) {
            self.text = text
        }
    }
}
