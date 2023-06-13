//
//  DogCard.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftData
import SwiftUI

struct DogCard: View {
    var dog: Dog
    
    var body: some View {
        DogImage(dog: dog)
            .overlay(alignment: .bottom) {
                HStack {
                    Text(dog.name)
                    Spacer()
                    Image(systemName: "heart")
                        .symbolVariant(dog.isFavorite ? .fill : .none)
                }
                .font(.headline)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(.thinMaterial)
            }
            .clipShape(.rect(cornerRadius: 16))
    }
    
    struct DogImage: View {
        var dog: Dog

        var body: some View {
            Rectangle()
                .fill(Color.green)
                .frame(width: 400, height: 400)
        }
    }

    @Observable
    class Dog: Identifiable {
        var id = UUID()
        var name = ""
        var isFavorite = false
    }
}
