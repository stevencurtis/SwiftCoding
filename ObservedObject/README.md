# What is Swift's @ObservedObject Property Wrapper?
## A way of monitoring state

I've got to admit it. I've been using the `ObservedObject` property wrapper to hold a view model in a view for the longest time, without really considering what it does or why.

So I've created this article as a breakdown of how `ObservedObject` works, how to use it effectively and some best practices.

# What is @ObservedObject?
`ObservedObject` is a property wrapper that marks a property in a view that references an observable object, conforming to the `ObservableObject` protocol. This allows the view to monitor the object conforming to `ObservableObject` for any changes, so the view knows when to update itself when the observed object's properties change.

This is commonly used when the backend updates should trigger UI changes.

# Using @ObservedObject
A view can hold onto the view model, so this can be accessed from within the view.

```swift
struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Text("\(viewModel.error?.localizedDescription)")
        .onAppear {
            viewModel.throwError()
        }
    }
}
```

It should be noted that `ObservedObject` should not be initilized directly in the view, as when the the view is recreated the `ObservedObject` would be reinitialized each time, potentially losing shared data. If you wish to create the instance in the view model `StateObject` is the right property wrapper for your needs.

# When to Use @ObservedObject
You should use `ObservedObject` when:

- A view relies on data from a shared model that might be updated by other parts of the app.
- You want changes in a model to reflect immediately in any views that use the model.

# Best Practices and Considerations

**Use `ObservedObject` with care**
Observing too many objects or creating deep dependency chains can lead to unexpected updates and performance issues. Keep the data flow simple and controlled.

**Avoid Retaining Observed Objects**
Views should not own observed objects if other parts of the app share the same object. Instead, pass observed objects down from parent views or higher-level components, ensuring a single source of truth.

**Combine with StateObject**
When creating a model in the view itself, consider StateObject instead, which initializes and owns the model instance. For injected models, ObservedObject is the appropriate choice.

**Testing Observed Properties**
Since observed properties rely on Combine's Published, test the observable objects separately to ensure they correctly publish changes without relying on SwiftUI's UI testing, which can be slower and more complex.

**Update Management**
In performance-sensitive apps, consider using tools like Combine's debounce to limit frequent updates, especially if the @Published properties update often or handle large datasets, as you may have experienced when managing large sets of transactional data.

# Conclusion
The `ObservedObject` property wrapper plays a significant role in SwiftUI's data management. It enables a responsive, reactive UI model that keeps the UI consistent with the latest data without needing imperative updates.

I certainly hope this article has helped you out!
