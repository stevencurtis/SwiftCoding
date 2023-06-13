//
//  TypesettingLanguage_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct TypesettingLanguage_Snippet: View {
    var dog = Dog(
        name: "ไมโล",
        language: .init(languageCode: .thai),
        imageName: "Puppy_Pitbull")

    func phrase(for name: Text) -> Text {
        Text(
            "Who's a good dog, \(name)?"
        )
    }

    var body: some View {
        HStack(spacing: 54) {
            VStack {
                phrase(for: Text("Milo"))
            }
            VStack {
                phrase(for: Text(dog.name))
            }
            VStack {
                phrase(for: dog.nameText)
            }
        }
        .font(.title)
        .lineLimit(...5)
        .multilineTextAlignment(.leading)
        .padding()
    }

    struct Dog {
        var name: String
        var language: Locale.Language
        var imageName: String

        var nameText: Text {
            Text(name).typesettingLanguage(language)
        }
    }
}

#Preview {
    TypesettingLanguage_Snippet()
}
