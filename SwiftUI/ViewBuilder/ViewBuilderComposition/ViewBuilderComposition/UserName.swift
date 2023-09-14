//
//  UserName.swift
//  ViewBuilderComposition
//
//  Created by Steven Curtis on 17/08/2023.
//

import SwiftUI

struct UserName: View {
    var name: String
    var body: some View {
        Text(name)
            .font(.headline)
    }
}

struct UserName_Previews: PreviewProvider {
    static var previews: some View {
        UserName(name: "name")
    }
}
