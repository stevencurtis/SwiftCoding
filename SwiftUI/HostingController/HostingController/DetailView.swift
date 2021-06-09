//
//  DetailViewController.swift
//  HostingController
//
//  Created by Steven Curtis on 23/04/2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("This is entirely a SwiftUIView")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel())
    }
}


