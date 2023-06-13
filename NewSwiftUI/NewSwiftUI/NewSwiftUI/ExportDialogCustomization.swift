//
//  ExportDialogCustomization.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ExportDialogCustomization: View {
    @State private var isExporterPresented = true
    @State private var selectedItem = ""
    
    var body: some View {
        Color.clear
            .fileExporter(
                isPresented: $isExporterPresented, item: selectedItem,
                contentTypes: [.plainText], defaultFilename: "ExportedData.txt")
            { result in
                handleDataExport(result: result)
            }
            .fileExporterFilenameLabel("Export Data")
            .fileDialogConfirmationLabel("Export Data")
    }

    func handleDataExport(result: Result<URL, Error>) {
    }

    struct Data: Codable, Transferable {
        static var transferRepresentation: some TransferRepresentation {
            CodableRepresentation(contentType: .plainText)
        }

        var text = "Exported Data"
    }
}
