//
//  RecentDogsView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct RecentDogsView: View {
    @Query(sort: \.dateSpotted) private var dogs: [Dog]

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(dogs) { dog in
                    DogCard(dog: dog)
                }
            }
        }
    }

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
    }

    struct DogImage: View {
        var dog: Dog

        var body: some View {
            Rectangle()
                .fill(Color.green)
                .frame(width: 400, height: 400)
        }
    }

    @Model
    class Dog: Identifiable {
        var name = ""
        var isFavorite = false
        var dateSpotted = Date.now
    }
}

#Preview {
    RecentDogsView()
}
