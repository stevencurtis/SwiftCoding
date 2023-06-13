//
//  DogGalleryCard.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct DogGalleryCard: View {
    @FocusState private var isFocused: Bool

    var body: some View {
        Button {
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue)
                    .frame(width: 888, height: 500)
                    .hoverEffect(.highlight)

                Text("Name")
                    .opacity(isFocused ? 1 : 0)
            }
        }
        .buttonStyle(.borderless)
        .focused($isFocused)
    }
}
