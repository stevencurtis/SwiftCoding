//
//  LazyVGridExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct LazyVGridExampleView: View {
    let colors: [Color] = [.red, .blue, .green]
    
    var columns: [GridItem] =
           Array(repeating: .init(.flexible(), alignment: .center), count: 3)

    var body: some View {
        ScrollView {

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0...100, id: \.self) { index in
                    Text("Cell \(index)")
                        .frame(width: 110, height: 200)
                        .background(colors[index % colors.count])
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct LazyVGridExampleView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridExampleView()
    }
}
