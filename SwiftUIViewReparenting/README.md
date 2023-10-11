# View Reparenting in SwiftUI
## Including @Namespace and matchedGeometryEffect

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) and be able to use SwiftUI

## Terminology
View: In SwiftUI a view is a protocol that defines a piece of user interface and is a building block for creating UI in SwiftUI
View reparenting: Changing the parent of a view after it has been created

# Prerequisites
## @Namespace
The [`@Namespace` property wrapper](https://medium.com/@stevenpcurtis/swiftuis-namespace-01a904402856) allows us to manage animations and transitions among views in SwiftUI. It will be used within the following article to move objects between sections in views.

# View Reparenting
View reparenting is where we can move a view from one parent to another. In order to do so we need to deal with a namespace so SwiftUI can compute and animate the transition between them.

# Code
## Essentially matchedGeometryEffect is 
We can have a view and use `[matchedGeometryEffect(id:in:properties:anchor:isSource:)](https://developer.apple.com/documentation/swiftui/view/matchedgeometryeffect(id:in:properties:anchor:issource:))` to link views with a namespace. Essentially SwiftUI computes and animates the movement of a unique item between parents. 

Do be aware that the .matchedGeometryEffect modifier can cause complex rendering operations, especially if used excessively or with complex view hierarchies. 

## The full code
It's not great. This is sample code where you can drag and drop items from one column to another. 

[columns](Images/columns.png)<br>

The `@Namespace` property wrapper is used to create a namespace for identifying views across the application. This is particularly useful when you want to perform animations or transitions between views, such as in drag-and-drop operations.

The `matchedGeometryEffect` modifier is applied to the Text view within the ForEach loop in both columns. It links the views with a shared identifier `(id: item)` within a namespace `(in: namespace)`, which is essential for animating the transition of a view from one parent to another during the drag-and-drop operation.

The `onDrag` modifier starts the drag operation when the user begins dragging a view. It finds the index of the item being dragged, removes it from its original list, and returns an NSItemProvider instance to represent the data being dragged.

The `onDrop` modifier handles the drop operation when the user releases the dragged item. It specifies the type of data being accepted (["public.text"]) and provides a delegate (DropDelegate) to handle the drop.

`DropDelegate` is a struct that conforms to `DropDelegate` protocol, and it handles the drop operation. The `performDrop(info:)` method processes the dropped data, and if it's valid, it adds the item back to the list in which it was dropped. The `dropUpdated(info:)` method proposes the operation type as .move, indicating that the data should be moved rather than copied or linked.

```swift
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
```

# Conclusion

I hope this article has helped someone out, and perhaps I'll see you at the next article?
