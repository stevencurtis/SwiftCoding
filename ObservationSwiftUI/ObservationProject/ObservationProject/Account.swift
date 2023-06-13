//
//  Account.swift
//  ObservationProject
//
//  Created by Steven Curtis on 13/06/2023.
//

import SwiftData
import SwiftUI

@Observable class Account {
  var userName: String? = ""
  var logOut: (() -> ()) = { print("logOut") }
  var showLogin: (() -> ()) = { print("showLogin") }
}

struct FoodTruckMenuView : View {
  @Environment(Account.self) var account

  var body: some View {
    if let name = account.userName {
        HStack { Text(name); Button("Log out") { (account.logOut)() } }
    } else {
      Button("Login") { account.showLogin() }
    }
  }
}
