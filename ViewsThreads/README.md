# Views shouldn't know about threads
## Think about this one

Views should be rather basic, right. Have we thought about
Read on to find out all the details!

Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 13.1, and Swift 5.5.1

## Terminology

Thread: Tasks can have their own threads of execution to stop long-running tasks block the execution of the rest of the application

# The motivation
Lots of my code has `DispatchQueue.main.async` to put us onto the main thread for UI work.

So this means that I might be communicating between a view model and view controller through a closure so I might have some code like the following:

```swift
self.viewModel.dictionarySet = { dict in
    let values = dict.allValues.description
    DispatchQueue.main.async {
         self.textView.text = values
    }
}
```

which, is fine. I mean without that `DispatchQueue.main.async` we would have a rather awkward crash which would not go down well with users. 
However, it means that the View Controller is in charge of threads. Now how does the View Controller (or the software developer who creates this particular View Controller) know that the values are delivered from the network? That's troublesome - right?

# An alternative

Rather than assuming the View Controller should know about the internal workings of the View Model why don't we put that `DispatchQueue.main.async` into the View Model? It's part of our public API so allows.
For this example, I've used *didSet* as my example of where I could put `DispatchQueue.main.async`.

```swift
var dictionary: NSDictionary = [:] {
    didSet {
        DispatchQueue.main.async {
            self.dictionarySet?(self.dictionary)
        }
    }
}
```

This isn't the only way to construct a view model, of course. 
You can pick apart the code for this on my [GitHub repository](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fstevencurtis%2FSwiftCoding%2Ftree%2Fmaster%2FViewsThreads)

# Conclusion

The approach taken above has been to list the property wrappers that you might use in your SwiftUI application. Now using them….potentially a different case.
Something to think about…
