//
//  UserBiography.swift
//  ViewBuilderComposition
//
//  Created by Steven Curtis on 17/08/2023.
//

import SwiftUI

struct UserBiography: View {
    var bio: String
    var body: some View {
        Text(bio)
            .font(.subheadline)
    }
}

struct UserBiography_Previews: PreviewProvider {
    static var previews: some View {
        UserBiography(bio: "test")
    }
}
