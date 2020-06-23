//
//  ColorExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct ColorExampleView: View {
    @State private var bgColor = Color.red

    var body: some View {
        VStack {
            ColorPicker("", selection: $bgColor)
        }
        .background(bgColor)
    }

}

struct ColorExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorExampleView()
    }
}
