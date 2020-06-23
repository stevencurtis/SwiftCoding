//
//  ChangeExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct ChangeExampleView: View {
    @State private var yourText = "Enter Your Text"
    var body: some View {
        Background {
            TextEditor(text: $yourText)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
        }
        .onChange(of: yourText) { newValue in
                       print("$yourText changed to \(yourText)!")
                   }
        .onTapGesture {
            self.endEditing()
        }
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ChangeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeExampleView()
    }
}
