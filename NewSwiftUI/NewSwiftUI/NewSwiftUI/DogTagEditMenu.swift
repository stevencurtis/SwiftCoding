//
//  DogTagEditMenu.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct DogTagEditMenu: View {
    @State private var selectedColor = TagColor.blue

    var body: some View {
        Menu {
            ControlGroup {
                Button {
                } label: {
                    Label("Cut", systemImage: "scissors")
                }
                Button {
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                Button {
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard.fill")
                }
                Button {
                } label: {
                    Label("Duplicate", systemImage: "plus.square.on.square")
                }
            }
            .controlGroupStyle(.compactMenu)

            Picker("Tag Color", selection: $selectedColor) {
                ForEach(TagColor.allCases) {
                    Label($0.rawValue.capitalized, systemImage: "tag")
                        .tint($0.color)
                        .tag($0)
                }
            }
            .paletteSelectionEffect(.symbolVariant(.fill))
            .pickerStyle(.palette)
        } label: {
            Label("Edit", systemImage: "ellipsis.circle")
        }
        .menuStyle(.button)
    }

    enum TagColor: String, CaseIterable, Identifiable {
        case blue
        case brown
        case green
        case yellow

        var id: Self { self }

        var color: Color {
            switch self {
            case .blue: return .blue
            case .brown: return .brown
            case .green: return .green
            case .yellow: return .yellow
            }
        }
    }
}
