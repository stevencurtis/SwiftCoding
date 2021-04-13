# Lazyily Load Images in Swift
## Don't forget the dependency injection!

![Photo by Manja Vitolic](Images/photo-1514888286974-6c03e2ca1dba.jpeg)<br/>
<sub>Photo by Manja Vitolic<sub>

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

You can access a video version of this article @[https://youtu.be/Szjjj4rWMIs](https://youtu.be/Szjjj4rWMIs)

A simple problem that requires an article - now perhaps you want to lazy load images in a UITableView; but how would you possibly do that?

Even more important - how can we use dependency injection for this?

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## The standard answer

You can use an extension for this, so we can call it straight after setting the image placeholder
```swift
imageView?.image = UIImage(named: "placeholder")
imageView?.downloadImage(with: urls[indexPath.row], contentMode: UIView.ContentMode.scaleAspectFit)
```

which calls code within an extension on `UIImageView`:

```swift
extension UIImageView {
    func downloadImage(with string: String, contentMode: UIView.ContentMode) {
        guard let url = NSURL(string: string) else {return}
        URLSession.shared.dataTask(with: url as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
```

We do need to be super careful when using this in a `UITableView` and using the standard `UITableViewCell` will not display the image which is lazily loaded UNLESS you first load the placeholder image

There is, unfortunately a **problem**. We are always using ```URLSession.shared``` for this code. We would be unable to test this code without using ```URLSession``` and therefore a genuine network call.


## The alternative answer
This can be done - and without changing the way that we can call the lazy loading of images too!

```swift
let imageView = UIImageView(image: UIImage(named: "PlaceholderImage"))
imageView.downloadImageFrom(with: url, contentMode: .scaleAspectFit)
```

we do need to use a Network Manager that can be exchanged - I've got one published on my [github account](https://github.com/stevencurtis/NetworkManager):

```swift
extension UIImageView {
    func downloadImageFrom(with url: URL, contentMode: UIView.ContentMode) {
        downloadImageFrom(with: url, network: NetworkManager(session: URLSession.shared), contentMode: contentMode)
    }
    
    func downloadImageFrom<T: NetworkManagerProtocol>(with url: URL, network: T, contentMode: UIView.ContentMode) {
        network.fetch(url: url, method: .get, completionBlock: { result in
            switch result {
            case .failure:
                print ("failed")
            // commnunicate failure to the user, or silently fail
            // as it will currently (leaves placeholder)
            case .success(let data):
                DispatchQueue.main.async {
                    self.contentMode = contentMode
                    self.image = UIImage(data: data)
                }
            }
        })

    }
```

Which can then be used with a mock `UIImageView` in order to check to see whether the image has actually been updated:

```swift 
class MockImageView: UIImageView {
    var finished: (()->())?
    override var image: UIImage? {
        didSet {
            super.image = image
            if let finished = finished {
                finished()
            }
        }
    }
}
```
We can then implement testing as follows:

```swift
func testupdateImage() {
        let expectation = XCTestExpectation(description: #function)
        let mockNetwork = MockNetworkManager(session: URLSession.shared)
        let imageData = UIImage(named: "Disclosure.png", in: Bundle(for: type(of: self)), compatibleWith: nil)?.pngData()
        mockNetwork.outputData = imageData
        let imageView = MockImageView()
        imageView.finished = {
            expectation.fulfill()
            XCTAssertEqual(imageView.image?.pngData(), imageData)
        }
        imageView.downloadImageFrom(with: URL(string: "www.google.com")!, network: mockNetwork, contentMode: .redraw)
        XCTAssertEqual(true, mockNetwork.didFetch)
        wait(for: [expectation], timeout: 2.0)
}
```

Now excuse the force-unwrap in the test - I often leave these in as it is in production code (in my opinion) where these really matter - crashing in a test is the same as a test failure. Your company may have different rules and protocols in place, that it OK. You might choose to use `XCTUnwrap`, it's all your choice!

Now would I usually use this alternative implementation? No, frankly, I wouldn't. You don't need to test the UI of your Implementation and can rely on your network stack being fully tested if you use something like [Alamofire](https://github.com/Alamofire/Alamofire).

## The full implementation
I've written this code in my [VIPER example](https://medium.com/@stevenpcurtis.sc/implement-the-clean-viper-architecture-in-ios-4e457d74a8ff), and please do take a look as this is a really nice article to read and learn from, and of course has this code in situ for you and ready to go!

# Conclusion
This is important stuff! You would want to lazily load images in a great deal of situations for creating Apps that are production ready. Before letting your users loose on your application you would like a great user experience. That is, you would really need to use lazy loading for your images. 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
