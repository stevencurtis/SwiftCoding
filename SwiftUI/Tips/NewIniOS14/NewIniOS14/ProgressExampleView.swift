//
//  ProgressExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct ProgressExampleView: View {
    @State private var progress = 0.0
    
    var body: some View {
        VStack{
            ProgressView("Progress", value: progress, total: 100)
            Button(action: {
                progress = (progress + 10).truncatingRemainder(dividingBy: 100)
            }
            ) {
                Text("Progress")
            }
        }
        
    }
    
    
}

struct ProgressExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressExampleView()
    }
}
