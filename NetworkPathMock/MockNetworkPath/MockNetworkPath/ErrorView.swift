//
//  ErrorView.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack {
            Color.red
                .frame(height: 50)
            HStack {
                Spacer()
                Text("Network disconnected")
                    .padding()
                Spacer()
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
