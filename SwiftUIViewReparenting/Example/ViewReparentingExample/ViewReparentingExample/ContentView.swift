//
//  ContentView.swift
//  ViewReparentingExample
//
//  Created by Steven Curtis on 21/08/2023.
//

import SwiftUI

struct DragAndDropExample: View {
    @Namespace private var namespace
    @State private var itemsInListA: [String] = ["Item 1", "Item 2", "Item 3"]
    @State private var itemsInListB: [String] = ["Item 4"]

    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("List A")
                VStack {
                    ForEach(itemsInListA, id: \.self) { item in
                        Text(item)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .matchedGeometryEffect(id: item, in: namespace)
                            .onDrag {
                                let itemIndex = itemsInListA.firstIndex(of: item)!
                                itemsInListA.remove(at: itemIndex)
                                return NSItemProvider(object: item as NSString)
                            }
                    }
                }
                .onDrop(of: ["public.text"], delegate: DropDelegate(list: $itemsInListA))
            }

            VStack {
                Text("List B")
                VStack {
                    ForEach(itemsInListB, id: \.self) { item in
                        Text(item)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .matchedGeometryEffect(id: item, in: namespace)
                            .onDrag {
                                let itemIndex = itemsInListB.firstIndex(of: item)!
                                itemsInListB.remove(at: itemIndex)
                                return NSItemProvider(object: item as NSString)
                            }
                    }
                }
                .onDrop(of: ["public.text"], delegate: DropDelegate(list: $itemsInListB))
            }
        }
        .padding()
    }
}

struct DropDelegate: SwiftUI.DropDelegate {
    @Binding var list: [String]

    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: ["public.text"]).first else { return false }
        itemProvider.loadItem(forTypeIdentifier: "public.text", options: nil) { (itemData, error) in
            DispatchQueue.main.async {
                if let itemData = itemData as? Data, let text = String(data: itemData, encoding: .utf8) {
                    self.list.append(text)
                }
            }
        }
        return true
    }

    func dropEntered(info: DropInfo) {}

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}

struct DragAndDropExample_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDropExample()
    }
}
