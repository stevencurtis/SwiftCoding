//
//  MultilineView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct MultilineView: View {
    @State private var yourText: String = "Enter your text here!"
    
    var body: some View {
        Background {
            TextEditor(text: $yourText)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
        }.onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}


struct MultilineView_Previews: PreviewProvider {
    static var previews: some View {
        MultilineView()
    }
}
