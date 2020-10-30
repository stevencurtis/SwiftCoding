//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by Steven Curtis on 24/09/2020.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(dataManager: DataManager())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct SwiftUICoreDataApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
