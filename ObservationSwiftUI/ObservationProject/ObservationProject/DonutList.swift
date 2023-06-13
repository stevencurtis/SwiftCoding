//
//  DonutList.swift
//  ObservationProject
//
//  Created by Steven Curtis on 13/06/2023.
//

//import SwiftData
//import SwiftUI
//
//@Observable class Donut: Identifiable {
//  var name: String = ""
//}
//
//struct DonutList: View {
//  var donuts: [Donut]
//  var body: some View {
//    List(donuts) { donut in
//      HStack {
//        Text(donut.name)
//        Spacer()
//        Button("Randomize") {
//          donut.name = randomName()
//        }
//      }
//    }
//  }
//}
//
//private func randomName() -> String {
//    let length = Int.random(in: 1..<10)
//    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//    return String((0..<length).map{ _ in letters.randomElement()! })
//}
