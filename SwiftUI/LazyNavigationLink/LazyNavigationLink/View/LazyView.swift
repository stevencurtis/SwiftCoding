//
//  LazyView.swift
//  LazyNavigationLink
//
//  Created by Steven Curtis on 10/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}
