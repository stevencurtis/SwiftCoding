//
//  DetailView.swift
//  AccessUIKit
//
//  Created by Steven Curtis on 26/04/2021.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ActivityIndicator()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        return view
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
}
