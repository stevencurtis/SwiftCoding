//
//  ConfirmationDialogCustomization.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ConfirmationDialogCustomization: View {
    @State private var showDeleteDialog = false
    @AppStorage("dialogIsSuppressed") private var dialogIsSuppressed = false

    var body: some View {
        Button("Show Dialog") {
            if !dialogIsSuppressed {
                showDeleteDialog = true
            }
        }
        .confirmationDialog(
            "Are you sure you want to delete the selected dog tag?",
            isPresented: $showDeleteDialog)
        {
            Button("Delete dog tag", role: .destructive) { }

//            HelpLink { }
        }
//        .dialogSeverity(.critical)
        .dialogSuppressionToggle(isSuppressed: $dialogIsSuppressed)
    }
}
