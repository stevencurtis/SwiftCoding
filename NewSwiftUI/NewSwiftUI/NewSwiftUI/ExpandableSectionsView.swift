//
//  ExpandableSectionsView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct ExpandableSectionsView: View {
    @State private var selection: Int?

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
        } detail: {
            Detail(selection: selection)
        }
    }

    struct Sidebar: View {
        @Binding var selection: Int?
        @State private var isSection1Expanded = true
        @State private var isSection2Expanded = false

        var body: some View {
            List(selection: $selection) {
                Section("First Section", isExpanded: $isSection1Expanded) {
                    ForEach(1..<6, id: \.self) {
                        Text("Item \($0)")
                    }
                }
                Section("Second Section", isExpanded: $isSection2Expanded) {
                    ForEach(6..<11, id: \.self) {
                        Text("Item \($0)")
                    }
                }
            }
        }
    }

    struct Detail: View {
        var selection: Int?

        var body: some View {
            Text(selection.map { "Selection: \($0)" } ?? "No Selection")
        }
    }
}
