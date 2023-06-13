//
//  ScrollingRecentDogsView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct ScrollingRecentDogsView: View {
    private static let colors: [Color] = [.red, .blue, .brown, .yellow, .purple]

    private var dogs: [Dog] = (1..<10).map {
        .init(
            name: "Dog \($0)", color: colors[Int.random(in: 0..<5)],
            isFavorite: false)
    }

    private var parks: [Park] = (1..<10).map { .init(name: "Park \($0)") }

    @State private var scrolledID: Dog.ID?

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dogs) { dog in
                    DogCard(dog: dog, isTop: scrolledID == dog.id)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                .opacity(phase.isIdentity ? 1 : 0)
                        }
                }
            }
        }
        .scrollPosition(id: $scrolledID)
        .safeAreaInset(edge: .top) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(parks) { park in
                        ParkCard(park: park)
                            .aspectRatio(3.0 / 2.0, contentMode: .fill)
                            .containerRelativeFrame(
                                .horizontal, count: 5, span: 2, spacing: 8)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .padding(.vertical, 8)
            .fixedSize(horizontal: false, vertical: true)
            .background(.thinMaterial)
        }
        .safeAreaPadding(.horizontal, 16.0)
    }
    
    struct DogCard: View {
        var dog: Dog
        var isTop: Bool

        var body: some View {
            DogImage(dog: dog)
                .overlay(alignment: .bottom) {
                    HStack {
                        Text(dog.name)
                        Spacer()
                        if isTop {
                            TopDog()
                        }
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
                .fill(dog.color.gradient)
                .frame(height: 400)
        }
    }

    struct TopDog: View {
        var body: some View {
            HStack {
                Image(systemName: "trophy.fill")
                Text("Top Dog")
                Image(systemName: "trophy.fill")
            }
        }
    }

    struct ParkCard: View {
        var park: Park

        var body: some View {
            RoundedRectangle(cornerRadius: 8)
                .fill(.green.gradient)
                .overlay {
                    Text(park.name)
                        .padding()
                }
        }
    }

    struct Dog: Identifiable {
        var id = UUID()
        var name: String
        var color: Color
        var isFavorite: Bool
    }

    struct Park: Identifiable {
        var id = UUID()
        var name: String
    }
}
