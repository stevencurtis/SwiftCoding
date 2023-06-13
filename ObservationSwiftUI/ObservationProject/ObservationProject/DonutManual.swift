//
//  DonutManual.swift
//  ObservationProject
//
//  Created by Steven Curtis on 13/06/2023.
//

import SwiftData

@Observable class Donut {
  private var someNonObservableLocation = DataStorage()
  var name: String {
    get {
      access(keyPath: \.name)
      return someNonObservableLocation.name
    }
    set {
      withMutation(keyPath: \.name) {
        someNonObservableLocation.name = newValue
      }
    }
  }
}

class DataStorage {
    var name: String = ""
}
