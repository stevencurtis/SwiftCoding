# Stop SPAMMING your API from a UISearchController
## When using the UISearchController be careful!

# Prerequisites:
You will need to be familiar with the basics of [Swift and able to start a Playground (or similar)](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
and be able to create a [`UITableView` programatically](https://stevenpcurtis.medium.com/the-programmatic-uitableview-example-e6936d5557af)

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 13.0, and Swift 5.3

# Terminology:
SearchViewController: A view controller that manages the display of search results based on interactions with a search bar.

# This Project
Oh, if you'd like the code for this it is [https://github.com/stevencurtis/SwiftCoding/tree/master/UISearchControllerAPI](https://github.com/stevencurtis/SwiftCoding/tree/master/UISearchControllerAPI)<br>

I've previously written an article on https://medium.com/@stevenpcurtis/a-basic-uisearchviewcontroller-swift-tutorial-7011888bca1 

how a `SearchController` can be used, and hinted at using an API to get results to display in a `UITableView` instance.

It works by making an API call each time the user presses a key on their device keyboard. Which potentially causes an issue.

## The potential problem
Users often make spelling mistakes, and also can actually type fast on their device. This means that there are many API calls made that any Back End needs to deal with. That is, your backend would need to deal with many, many requests.

You would wish to minimize the frequency of these requests, as equivalently each one does cost money for your business. The question is, how to implement this.

## Minimizing API calls
Rather than making an unlimited number of API calls for the user, it would be better to make one after a delay (so a less frequent number of calls). 

Almost unbelievably, this is actually something we can do in Swift.

## The implementation
I often use a simple MVVM implementation for these articles, and the code in the repo reflects this. 

The heart of this code is 

```swift
func perform(_ aSelector: Selector, with anArgument: Any?, afterDelay delay: TimeInterval)
```

which runs some code on the current thread after a delay. This isn't enough though, as we would be in effect making a queue of calls. We actually need to **cancel** existing callings before we make subsequent calls. 

So our **search** function will look something like the following:

```swift 
func makeSearch(with term: String) {
    NSObject.cancelPreviousPerformRequests(withTarget: self)
    perform(#selector(search(_:)), with: term, afterDelay: TimeInterval(1.0))
}
```

which then calls the function which makes the API call (in the code in the repo this is a fake API call, no real BE has been created in conjunction with this article).

By cancelling existing calls before making the next we are creating more efficient experiences for our users.

# Conclusion
Minimizing calls to a BE is really important not only for the running costs on any particular Apps, but for the responsiveness of your App.

Providing better experiences for our users is really important, and is what we should be thinking about for our mobile applications. If we can also make sure that our mobile applications are efficient in the Backend calls we are making we will also make sure that our app is cost efficient and responsive. That is, a win-win.

I hope this article helps you, and you enjoy your time coding.

Subscribing to Medium using [this link](https://stevenpcurtis.medium.com/membership) shares some revenue with me.

If you’ve any questions, comments or suggestions [please hit me up on Twitter](https://twitter.com/stevenpcurtis)
