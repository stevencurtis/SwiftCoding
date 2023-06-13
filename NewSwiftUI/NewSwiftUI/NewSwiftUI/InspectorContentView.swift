//
//  InspectorContentView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct InspectorContentView: View {
    @State private var inspectorPresented = true
    
    var body: some View {
        DogTagEditor()
            .inspector(isPresented: $inspectorPresented) {
                DogTagInspector()
            }
    }
    
    struct DogTagEditor: View {
        var body: some View {
            Color.clear
        }
    }
    
    struct DogTagInspector: View {
        @State private var fontName = FontName.sfHello
        @State private var fontColor: Color = .white
        
        var body: some View {
            Form {
                Section("Text Formatting") {
                    Picker("Font", selection: $fontName) {
                        ForEach(FontName.allCases) {
                            Text($0.name).tag($0)
                        }
                    }

                    ColorPicker("Font Color", selection: $fontColor)
                }
            }
        }
    }

    enum FontName: Identifiable, CaseIterable {
        case sfHello
        case arial
        case helvetica

        var id: Self { self }
        var name: String {
            switch self {
            case .sfHello: return "SF Hello"
            case .arial: return "Arial"
            case .helvetica: return "Helvetica"
            }
        }
    }
}

#Preview {
    InspectorContentView()
}
