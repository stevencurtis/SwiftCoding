//
//  TableDisplayCustomizationView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct TableDisplayCustomizationView: View {
    private var dogSightings: [DogSighting] = (1..<10).map {
        .init(
            name: "Dog Breed \($0)", sightings: Int.random(in: 1..<5),
            rating: Int.random(in: 1..<6))
    }

    @State private var selection: DogSighting.ID?

    var body: some View {
        Table(dogSightings, selection: $selection) {
            TableColumn("Name", value: \.name)
            TableColumn("Sightings") {
                Text($0.sightings, format: .number)
            }
            TableColumn("Rating") {
                StarRating(rating: $0.rating)
                    .foregroundStyle(.starRatingForeground)
            }
        }
        // .alternatingRowBackgrounds(.disabled)
        .tableColumnHeaders(.hidden)
    }

    struct StarRating: View {
        var rating: Int

        var body: some View {
            HStack(spacing: 1) {
                ForEach(1...5, id: \.self) { n in
                    Image(systemName: "star")
                        .symbolVariant(n <= rating ? .fill : .none)
                }
            }
            .imageScale(.small)
        }
    }

    struct StarRatingForegroundStyle: ShapeStyle {
        func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
            if environment.backgroundProminence == .increased {
                return AnyShapeStyle(.secondary)
            } else {
                return AnyShapeStyle(.yellow)
            }
        }
    }

    struct DogSighting: Identifiable {
        var id = UUID()
        var name: String
        var sightings: Int
        var rating: Int
    }
}

extension ShapeStyle where Self ==
    TableDisplayCustomizationView.StarRatingForegroundStyle
{
    static var starRatingForeground: TableDisplayCustomizationView.StarRatingForegroundStyle {
        .init()
    }
}
