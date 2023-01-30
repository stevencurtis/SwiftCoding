//
//  DetailView.swift
//  LazyNavigationLink
//
//  Created by Steven Curtis on 09/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    var body: some View {
        Text(viewModel.text)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(text: "test"))
    }
}
