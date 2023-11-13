//
//  ButtonView.swift
//  
//
//  Created by Steven Curtis on 27/10/2023.
//

import SwiftUI

public struct SimpleButtonView: View {
    public var action: () -> Void
    public var buttonText: String
    
    public init(action: @escaping () -> Void, buttonText: String) {
        self.action = action
        self.buttonText = buttonText
    }

    public var body: some View {
        Button(action: action) {
            Text(buttonText)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
