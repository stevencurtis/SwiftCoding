//
//  DogGenealogyTable.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct DogGenealogyTable: View {
    private static let dogToys = ["🦴", "🧸", "👟", "🎾", "🥏"]

    private var dogs: [DogGenealogy] = (1..<10).map {
        .init(
            name: "Parent \($0)", age: Int.random(in: 8..<12) * 7,
            favoriteToy: dogToys[Int.random(in: 0..<5)],
            children: (1..<10).map {
                .init(
                    name: "Child \($0)", age: Int.random(in: 1..<5) * 7,
                    favoriteToy: dogToys[Int.random(in: 0..<5)])
            }
        )
    }

    var body: some View {
        Table(of: DogGenealogy.self) {
            TableColumn("Dog Name", value: \.name)
            TableColumn("Age (Dog Years)") {
                Text($0.age, format: .number)
            }
            TableColumn("Favorite Toy", value: \.favoriteToy)
        } rows: {
            ForEach(dogs) { dog in
                DisclosureTableRow(dog) {
                    ForEach(dog.children) { child in
                        TableRow(child)
                    }
                }
            }
        }
    }

    struct DogGenealogy: Identifiable {
        var id = UUID()
        var name: String
        var age: Int
        var favoriteToy: String
        var children: [DogGenealogy] = []
    }
}
