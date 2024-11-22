# SwiftUI's State Management 
## Fun Management!

When using SwiftUI we benefit from understanding how state is managed through the App that uses the state.
This is crucial in SwiftUI, from simple data properties to shared states across view it's something you cannot ignore if you hope to make responsive good quality apps.
This article dives into SwiftUI state management, covering challenges, property wrappers and more.

# State Challenges
**Complexity**
The number of states which need to be managed can grow as applications grow.

This state explosion needs to be managed as state variables overlap, interact and potentially conflict. To avoid this (and to make debugging a little easier) adopting clear state management practices, using layers and modularity is crucial to handle the resultant complexity in the app.

**Property wrappers**
It can be challenging to get to grips with SwiftUI's property wrappers and state management. This can be challenging for those who are used to working with UIKit.
Here are some of my articles that relate to the property wrappers.
@State: https://stevenpcurtis.medium.com/the-state-swiftui-property-wrapper-6e46a1b31ba5
@Binding: https://stevenpcurtis.medium.com/the-binding-property-wrapper-7a692edb48d4
@ObservedObject and ObservableObject:  https://medium.com/@stevenpcurtis/what-is-swifts-observedobject-property-wrapper-46aedcb01cd3
@EnvironmentObject: https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/EnvironmentPropertyWrapper
@Environment: https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUI/EnvironmentPropertyWrapper

**View redraws**
If state is not correctly managed view redraws can affect performance. Understanding how views are managed and the view hierarchy can produce more performant code.

**Data flow**
Having a single source of truth for state and understanding the flow of data between SwiftUI views can be complex when we factor in parent-child relationships and environment objects.

** Shared state**
Different parts of the UI might rely on shared state leading to side effects. That is change in one part of the app could inadvertently affect another part of the app.

**Concurrency and memory management**
We need to be mindful of changes we make to state without causing race conditions or deadlocks. Storing too much state can lead to increased memory usage.

# Conclusion
I hope this article has helped someone out, and perhaps I'll see you at the next article?
