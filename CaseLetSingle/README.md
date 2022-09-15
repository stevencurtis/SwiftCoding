# I've finally mastered Case Let

You know how you can always do things better in life. Certainly you can. I've previously [created a micro-project](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fdecode-json-in-swift-a-full-micro-project-dd88c434921) around downloading a JSON String and writing the result to the screen. 
There is nothing special going on in terms of the completion - I'm just returning a closure `((Users) -> Void)?` which I guess is *fine* in some sense.

##So..what gives?
Returning a Result type would give much greater flexibility. Why? 

Well, we need to think about errors that are returned from the backend or whatever - in the [original implementation](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fdecode-json-in-swift-a-full-micro-project-dd88c434921) we aren't handling those errors.

That's a little bit rubbish overall. 
We can instead let the `ViewModel` return a closure

```var closure: ((Result<Users, Error>) -> Void)?```

which the viewModel can then use to process (instead of printing this we could write it to a `UITextView`, if we wrapped it in a `DispatchQueue.main.async`
 to make sure we would be on the main thread) although in this case we are printing out the result to the console.

An implementation of that might look something like the following:

```
viewModel.closure = { result in
    switch result {
    case let .success(users):
        print(users.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n"))
    case .failure(_):
        break
    }
}
```

That's much better! Ok, I accept that I'm not actually handling that failure case but the point is that I could be (I'd suggest using a `UIAlertView` or something to inform to the user or the failure).

##So..what's wrong with that?
You know, kind of nothing. There is a break so we are ready to use the failure case and implement it at some point.

But you know what, we haven't used that case. The break is not too helpful for anyone in this code. This can be solved with case let, and you know this is rather more concise.

```
viewModel.closure = { result in
    if case let .success(users) = result {
        print(users.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n"))
    }
}
```

This is because we haven't included the failure case. This has actually gone from the code! Everything is a bit easier to read now! Great!

##Why mastering case let
You might wonder why I've titled this article as **I've finally mastered Case Let**, and fair question reader.

What has happened here is I've found this syntax really difficult to master, and especially where there is an associated value (like the example above).

In any case, I hope this article makes things a little easier for you to read and things to be a little more understandable!

#Conclusion
I hope you enjoyed that rather short article. Please do keep a look out for me, if you are interested in such articles in the future! Thank you!
If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
