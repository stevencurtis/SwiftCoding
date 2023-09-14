//
//  ProfilePicture.swift
//  ViewBuilderComposition
//
//  Created by Steven Curtis on 17/08/2023.
//

import SwiftUI

struct ProfilePicture: View {
    var body: some View {
        Image("CircularProfile")
            .resizable()
            .frame(width: 204, height: 170)
            .clipShape(Circle())
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
