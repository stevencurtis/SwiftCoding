# Multiple Initializers in Swift
## For your class, or struct (or even enum)

# Prerequisites:
You will need to be familiar with the basics of [Swift and able to start a Playground (or similar)](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
It would also be handy to know about [classes and structs](https://medium.com/swift-coding/when-to-use-class-or-struct-in-swift-e6037147c1d)

# Terminology:
Initialization: the process of preparing an instance of a class, structure, or enumeration for use
Initializer: methods used to create an instance of a particular type

If you want a video version of this article you can [take a look](https://youtu.be/AkfVqvP_pvE)

So: Imagine that you'd like to use a reusable cell to either display an image

[cell1](Images/cell1.png)<br>
or some text

[cell2](Images/cell2.png)

What are we to do?

# Why not use 2 cells?
Please don't use 2 different `UITableViewCell` instances. Please, that's just wrong because either we aren't reusing code or it's just not a good example for this article.

The thing is, this article is about reusing a `UITableViewCell` for two different types of data should be simple. It doesn't need to be as extreme as an image vs. text as that's just an example (so don't panic!)

# The setup
I'd say that my setup is really my [standard setup](https://medium.com/@stevenpcurtis.sc/a-customuitableviewcell-in-uitableview-10b5893453c) for `UITableView` and `UITableViewCell` - but in this instance I'm using a View model for the cell (as well as a nib).

What does that mean?

In the `UITableViewCell` I'm using a `configure(with:` method, which is nice but the meat of the work goes in in what I'm calling `ContentTableViewCellViewModel`.

To look in detail at this you can always see the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/MultipleInitializers).

Oh, the image is from the asset catalog, and you can also see that in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/MultipleInitializers).

# Use a single initializer

So for the  `ContentTableViewCellViewModel` we can use an initializer:

```swift
struct ContentTableViewCellViewModel {
    let image: UIImage?
    let title: String?
    
    init(image: UIImage?, title: String?) {
        self.image = image
        self.title = title
    }
}
```
Of course we don't need the initailizer here as you get a free [memberwise initializer](https://stevenpcurtis.medium.com/new-features-in-swift-5-1-e538e33013b) but it is here for completion's sake. 

This is then consumed by the `ContentTableViewCell` so it would be something like:

```swift
class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: ContentTableViewCellViewModel) {
        if let image = model.image {
            profileImageView.image = image
            titleLabel.isHidden = true
            profileImageView.isHidden = false
        } else {
            titleLabel.text = model.title
            profileImageView.isHidden = true
            titleLabel.isHidden = false
        }
    }
}
```
Wonderful! Aren't we done?

Wait! We can have both an `UIImageView` and a `String` in this solution - and our cell does not actually support that!

What are we to do?

# Use two initializers
So we can shape that `ContentTableViewCellViewModel` to use two initializers.

```swift
struct ContentTableViewCellViewModel {
    let image: UIImage?
    let title: String?
    
    init(title: String?) {
        self.image = nil
        self.title = title
    }
    
    init(image: UIImage?) {
        self.image = image
        self.title = nil
    }
}
```
Which is *Ok*, fine. But we can do better can't we? I mean, it is clear to the caller (in my opinion) which initializer to use for which case but it's not elegant. Furthermore, sometimes you want several properties in order to make up your cell.

# I'd use an enum
Yes indeed. I'd use an `enum` for that ([there are articles on enum](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjj7_-Cu__zAhUGZcAKHaoJAiEQFnoECAoQAQ&url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fclasses-enums-or-structures-how-to-choose-your-swift-type-f33b4b76230e&usg=AOvVaw1sbPqu9lawK2dl3bp0WV__)) which means the caller can decide what they want to use to create the cell.

Something like:

```swift
struct ContentTableViewCellViewModel {
    let image: UIImage?
    let title: String?

    enum CellContent {
        case image(UIImage?)
        case title(String)
    }
    
    init(content: CellContent) {
        switch content {
        case let .image(image):
            self.image = image
            self.title = nil
        case let .title(title):
            self.title = title
            self.image = nil
        }
    }
}
```

So then we will need to have a new method:

```swift
class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with content: ContentTableViewCellViewModel.CellContent) {
        switch content {
        case let .image(image):
            profileImageView.image = image
            titleLabel.isHidden = true
            profileImageView.isHidden = false
        case let .title(title):
            titleLabel.text = title
            profileImageView.isHidden = true
            titleLabel.isHidden = false
        }
    }
}
```

Which, although I'm not that keen on the [case let syntax](https://stevenpcurtis.medium.com/ive-finally-mastered-case-let-in-my-swift-code-7b1737cf52c3)) and setting elements you're not using in a relevant case, it's ... much better.

You can call this using one of these in your `cellForRowAt` function:

```swift
cell.configure(with: .title("text"))
cell.configure(with: .image(.name("CircularProfile")))
```

(remember only use one!)

However, I'm STILL not happy with the solution. Why?

```swift
let image: UIImage?
```
is optional because the image from the asset catalog is optional.

# I hate optional images

You need to feed in the optional image, because an image from the asset catalog is optional. Not great.

You *could* pass in the `String` name of the image and sort it out in the `UITableViewCell`. 

I'd rather sort out the solution to the problem: to use typed images. To do that? You could try [this](https://github.com/mac-cain13/R.swift) third-party dependency. That would be nice wouldn't it?

# Conclusion

I hope this article has been of help to you. The idea here is to get thinking, and to consider how to do things better when you're coding.

Isn't that what it's all about in the end?

Subscribing to Medium using [this link](https://stevenpcurtis.medium.com/membership) shares some revenue with me.

If you’ve any questions, comments or suggestions [please hit me up on Twitter](https://twitter.com/stevenpcurtis)
