//
//  DonutListView.swift
//  ObservationProject
//
//  Created by Steven Curtis on 12/06/2023.
//

//import SwiftUI
//
//struct DonutListView: View {
//    var donutList: DonutList
//    @State private var donutToAdd: Donut?
//    
//    var donutName: Binding<String> {
//        Binding<String>(
//            get: { self.donutToAdd?.name ?? "" },
//            set: { self.donutToAdd?.name = $0 }
//        )
//    }
//    
//    var body: some View {
//        List(donutList.donuts) { DonutView(donut: $0) }
//        Button("Add Donut") { donutToAdd = Donut() }
//            .sheet(item: $donutToAdd) {_ in
//                TextField("Name", text: donutName)
//                Button("Save") {
//                    if let donut = donutToAdd {
//                        donutList.donuts.append(donut)
//                    }
//                    donutToAdd = nil
//                }
//                Button("Cancel") { donutToAdd = nil }
//            }
//    }
//}
//
//final class DonutList {
//    var donuts: [Donut]
//    init(donuts: [Donut]) {
//        self.donuts = donuts
//    }
//}
//
//struct DonutView: View {
//    var donut: Donut
//    
//    var body: some View {
//        Text(donut.name)
//    }
//}
//
//#Preview {
//    DonutListView(donutList: DonutList(donuts: [.init(id: UUID(), name: "Donut", price: 1.0)]))
//}
