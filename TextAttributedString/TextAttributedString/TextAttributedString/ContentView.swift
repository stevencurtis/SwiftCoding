//
//  ContentView.swift
//  TextAttributedString
//
//  Created by Steven Curtis on 08/04/2023.
//

import SwiftUI

struct ContentView: View {
    @available(iOS 15.0, *)
    var message: AttributedString {
        var redString = AttributedString("Is this red?")
        redString.font = .systemFont(ofSize: 18)
        redString.foregroundColor = .red
        var largeString = AttributedString("This should be larger!")
        largeString.font = .systemFont(ofSize: 24)
        return redString + largeString
    }
    
    var messageAttributed: NSAttributedString {
        let redString =  NSMutableAttributedString(string: "Is this red? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let largeString = NSAttributedString(string: "This should be larger!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
        redString.append(largeString)
        return redString
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Is this red?")
                    .font(.system(size: 18))
                    .foregroundColor(.red)
                Text("This should be larger!")
                    .font(.system(size: 24))
            }
            Text(messageAttributed)
            if #available(iOS 15.0, *) {
                Text(message)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
