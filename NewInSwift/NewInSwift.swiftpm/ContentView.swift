import SwiftUI

struct ContentView: View {
    enum Destination { case one, two }
    
    var body: some View {
        HStack{
            Text("Direction")
            Spacer()
            Text("On Direction")
            .pickerStyle(SegmentedPickerStyle())
        }
        
        Picker("From status", selection: "025") {
            ForEach(Self.orderStatusFromArray, id: \.self) { status in
                Text(status)
            }
        }
    }
}
