//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Steven Curtis on 24/09/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var dataManager: DataManager

    var body: some View {
        NavigationView {
            List {
                ForEach(dataManager.objectArray, id: \.self) { obj in
                    Text( (obj.value(forKey: Constants.timeAttribute) as! Date).description )
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.addItem()
                                    }) {
                                        Text("Add")
                                    }, trailing: EditButton()
            )
        }
    }
    
    private func addItem() {
        dataManager.save(date: Date(), completion: {
            print ("completed save")
        })
    }

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            print ("index \(index)")
            dataManager.delete(object: dataManager.objectArray[index])
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            dataManager: DataManager()).environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
