//
//  ContentView.swift
//  LazyNavigationLink
//
//  Created by Steven Curtis on 09/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.animals, id: \.self) {
                    animal in
                    NavigationLink(destination: LazyView {
                        DetailView(viewModel: DetailViewModel(text: animal))
                        })
                    {
                        Text(animal)
                    }
                    //                        NavigationLink(
                    //                            destination:
                    //                            DetailView(viewModel: DetailViewModel(text: animal))
                    //                        ) {
                    //                            Text(animal)
                    //                        }
                }
            }
            .navigationBarTitle("Animals")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel() )
    }
}
