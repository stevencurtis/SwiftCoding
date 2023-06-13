//
//  DonutMenuExample2.swift
//  ObservationProject
//
//  Created by Steven Curtis on 09/06/2023.
//

//import SwiftData
//import SwiftUI
//
//struct Order {
//    let orderNo: String
//}
//
//struct Donut: Identifiable {
//    var id: UUID = UUID()
//    var name: String = ""
//    var price: Double = 0.00
//
//    static let donuts = [
//        Donut(name: "Glazed", price: 1.0),
//        Donut(name: "Chocolate", price: 1.5),
//        Donut(name: "Sprinkles", price: 1.2)
//    ]
//    
//    static var all: [Donut] {
//        return donuts
//    }
//}
//
//@Observable class FoodTruckModel {
//  var orders: [Order] = []
//  var donuts = Donut.all
//  var orderCount: Int { orders.count }
//}
//
//extension FoodTruckModel {
//    func addDonut() {
//        donuts.append(Donut(name: "Donut", price: 0.5))
//    }
//}
//
//struct DonutMenu: View {
//  let model: FoodTruckModel
//    
//  var body: some View {
//    List {
//      Section("Donuts") {
//        ForEach(model.donuts) { donut in
//          Text(donut.name)
//        }
//        Button("Add new donut") {
//          model.addDonut()
//        }
//      }
//        Section("Orders") {
//            LabeledContent("Count", value: "\(model.orderCount)")
//        }
//    }
//  }
//}
//
//#Preview {
//    DonutMenu(model: .init())
//}
