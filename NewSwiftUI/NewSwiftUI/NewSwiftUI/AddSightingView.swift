//
//  AddSightingView.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftData
import SwiftUI

struct AddSightingView: View {
    @State private var model = DogDetails()

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.dogName)
                DogBreedPicker(selection: $model.dogBreed)
            }
            Section {
                TextField("Location", text: $model.location)
            }
        }
    }

    struct DogBreedPicker: View {
        @Binding var selection: DogBreed

        var body: some View {
            Picker("Breed", selection: $selection) {
                ForEach(DogBreed.allCases) {
                    Text($0.rawValue.capitalized)
                        .tag($0.id)
                }
            }
        }
    }

    @Observable
    class DogDetails {
        var dogName = ""
        var dogBreed = DogBreed.mutt
        var location = ""
    }

    enum DogBreed: String, CaseIterable, Identifiable {
        case mutt
        case husky
        case beagle

        var id: Self { self }
    }
}

#Preview {
    AddSightingView()
}
