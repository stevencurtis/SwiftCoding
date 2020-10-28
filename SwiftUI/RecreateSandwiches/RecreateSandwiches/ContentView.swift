//
//  ContentView.swift
//  RecreateSandwiches
//
//  Created by Steven Curtis on 09/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: SandwichStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.sandwiches) { sandwich in
                    SandwichCell(sandwich: sandwich)
                }
                .onMove(perform: moveSandwiches)
                .onDelete(perform: deleteSandwiches)
                HStack {
                    Spacer()
                    Text("\(store.sandwiches.count) Sandwiches")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Sandwiches")
            .toolbar {
                Button("Add", action: makeSandwich)
                Spacer()
                EditButton()
            }
        }
        
    }
    
    func makeSandwich() {
        withAnimation {
            store.sandwiches.append(Sandwich(name: "Patty melt",
                ingredientCount: 3 ))
        }
    }
    
    func moveSandwiches(from: IndexSet, to: Int) {
        withAnimation {
            store.sandwiches.move(fromOffsets: from, toOffset: to)
        }
    }

    func deleteSandwiches(offsets: IndexSet) {
        withAnimation {
            store.sandwiches.remove(atOffsets: offsets)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: testData)
            ContentView(store: testData)
            ContentView(store: testData)
                .frame(width: 1.0)
            ContentView(store: testData)
                .frame(width: 1.0)
                
            ContentView(store: testData)
        }
    }
}


struct SandwichCell: View {
    var sandwich: Sandwich
    
    var body: some View {
        NavigationLink( destination: SandwichDetail(sandwich: sandwich)) {
            Image(sandwich.thumbnailName)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(sandwich.name)
                Text("\(sandwich.ingredientCount) ingredients")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}


