//
//  ProgressSpinner.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct ProgressSpinner: View {
    var body: some View {
        ProgressView("This will never finish!")
    }
}

struct ProgressSpinner_Previews: PreviewProvider {
    static var previews: some View {
        ProgressSpinner()
    }
}
