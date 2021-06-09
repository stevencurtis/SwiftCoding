//
//  PurpleUIView.swift
//  HostingController
//
//  Created by Steven Curtis on 23/04/2021.
//

import SwiftUI

struct PurpleUIView: View {
    var buttonCallback: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.purple
            Button(action: {
                self.buttonCallback?()
            }) {
                Text("Move on")
            }
        }
    }
}

struct PurpleUIView_Previews: PreviewProvider {
    static var previews: some View {
        PurpleUIView()
    }
}
