# WWDC 2023: What's New In UIKit
## Well, I'm Still Using UIKit

This particular article isn't intended to replace the video from WWDC. Rather it's an in-situ example of how the code in the video works, so instead of needing to copy-paste the code from the video we have a full working example in the repo along with this article.
This also doesn't cover everything in the video, just the things that I've found most interesting. So my recommendation is to use Apple's video https://developer.apple.com/videos/play/wwdc2023/10055/ and use this article to help you where needed.

# Key Features
## UIKit Previews
The new preview macro is great! I can use it to instantiate view controllers programmatically or through the storyboard. Here is an example (which is in the repo):

```swift
#Preview("ViewController") {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let customViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
    return customViewController
}
```

## View controller lifecycle
The view controller lifecycle has been updated, and what is better is it has been back deployed to iOS13 so most of us should be able to use it (even when we support users on older iOS versions).
This is a good place to do things as the view appears, since the view controller and the view have an updated trait collection. So code that depends on the size and geometry of the view and be run.
I created a basic view controller to demonstrate this.

```swift
final class ViewControllerLifecycle: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewIsAppearing")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
}
```

Gives the output

```swift
viewDidLoad
viewWillAppear
viewIsAppearing
viewDidAppear
```

So `viewIsAppearing` is called in between `viewWillAppear` and `viewDidAppear`.

##Animation symbol images
We can use .addSymbolEffect on UIImageView instances. I put the following a viewDidLoad function of a view controller in my example.

```swift
imageView.image = UIImage(systemName: "speaker.wave.3")
imageView.addSymbolEffect(.bounce)
imageView.removeSymbolEffect(ofType: .variableColor)
```

## Empty states
Apple have provided a config for loading and for empty states. Even better we can use a SwiftUI view to be able to show a custom view for users.
In my example I've used viewDidLoad to get the following to work:
```swift
override func viewDidLoad() {
        super.viewDidLoad()

        var config = UIContentUnavailableConfiguration.empty()
        config.image = UIImage(systemName: "star.fill")
        config.text = "No"
        config.secondaryText = "Your favorite translations will appear here."
        contentUnavailableConfiguration = config
    }
```
and
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        let config = UIHostingConfiguration {
            VStack {
                ProgressView(value: progress)
                Text("Downloading file...")
                    .foregroundStyle(.secondary)
            }
        }
        contentUnavailableConfiguration = config
    }
```
And the following for a search view controller
```swift
override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config: UIContentUnavailableConfiguration?
        if searchResults.isEmpty {
            config = .search()
        }
        contentUnavailableConfiguration = config
    }
```

# Best of the rest
## iPad features
There looks to be lots of great iPad features (including new pen inks) but I don't have production code running on an iPad right now, so it of limited interest to me. Although I'm an interested user!

## Internationalization
I'm really interested in internationalization due to a previous project I got involved in. Anything to make supporting languages and character sets is a good thing!

## Spring animations
I think animations is a hot thing with SwiftUI. It's good to see UIKit getting a bit of a refresh in this case, and it's all exciting stuff!

# Conclusion
That's so much new UIKIt stuff. I think I'll write a number of articles on these topics, particularly animations and some of the more niche topics - I didn't even mention the status bar and I think that is something most people will use.
Anyway, thanks for reading!
I'd love to hear from you if you have questions for me!
Subscribing to Medium using this link shares some revenue with me, or you might like to help me out by buying me a coffee on https://www.buymeacoffee.com/stevenpcuri.
