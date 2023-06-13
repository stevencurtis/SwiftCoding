//
//  DogSightingsTable.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct DogSightingsTable: View {
    private var dogSightings: [DogSighting] = (1..<50).map {
        .init(
            name: "Sighting \($0)",
            date: .now + Double((Int.random(in: -5..<5) * 86400)))
    }

    @SceneStorage("columnCustomization")
    private var columnCustomization: TableColumnCustomization<DogSighting>
    @State private var selectedSighting: DogSighting.ID?
    
    var body: some View {
        Table(
            dogSightings, selection: $selectedSighting,
            columnCustomization: $columnCustomization)
        {
            TableColumn("Dog Name", value: \.name)
                .customizationID("name")
            
            TableColumn("Date") {
                Text($0.date, style: .date)
            }
            .customizationID("date")
        }
    }
    
    struct DogSighting: Identifiable {
        var id = UUID()
        var name: String
        var date: Date
    }
}
