# 8 Tips for Performant SwiftUI
## I hope this helps!

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) and be able to use SwiftUI

## Terminology
View: In SwiftUI a view is a protocol tht defines a piece of user interface and is a building block for creating UI in SwiftUI

# Practices

1. Efficient Redraws:
As mentioned, SwiftUI only redraws the differences (diffs) in the view hierarchy. This is inherently performant, but you can further optimize by ensuring that only necessary parts of your UI update in response to state changes.
2. Use of EquatableView:
As you've detailed, using EquatableView can help avoid unnecessary redraws for complex views. By providing custom logic to determine if a view has changed, you can minimize the work SwiftUI has to do.
3. Avoiding Expensive Computations in body:
The body property of a SwiftUI view can be called frequently. Avoid placing expensive computations or operations directly in the body. Instead, use background threads, caching, or other optimization techniques.
4. Lazy Loading:
For lists with many items, consider using LazyVStack or LazyHStack, which only load views as they come on screen. This can significantly improve scroll performance.
5. State and Data Flow:
Be mindful of how data flows through your app. Excessive or unnecessary bindings can lead to more view updates than required. Use @State, @Binding, @ObservedObject, and @EnvironmentObject judiciously.
6. Animations:
Animations can impact performance. Ensure that animations are smooth by optimizing the views being animated and avoiding animating large view hierarchies simultaneously.
7. Profiling with Instruments:
Regularly profile your app using Xcode's Instruments tool. This can help identify performance bottlenecks, memory leaks, or other issues that might affect performance.
8. Memory Management:
While SwiftUI views are transient and lightweight, be cautious of retaining large data structures or creating strong reference cycles, especially when using closures.

# Conclusion

I hope this article has helped someone out, and perhaps I'll see you at the next article?
