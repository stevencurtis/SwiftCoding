//
//  PageTabViewStyleExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct PageTabViewStyleExampleView: View {
    let colors: [Color] = [.red, .green, .orange, .blue]

    var body: some View {
        TabView {
            ForEach(0..<4) { index in
                    Text("Tab \(index)")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colors[index])
                    .cornerRadius(8)
                }
        }.tabViewStyle(PageTabViewStyle())
    }
}

struct PageTabViewStyleExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTabViewStyleExampleView()
    }
}
