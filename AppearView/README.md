# An Accordion View in Swift and UIKit
## Involving constraints

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

UIKit isn't dead. Not around these parts at least. 
In web design, an accordion is a type of menu that displays a list of headers stacked on top of one another. When clicked on (or triggered by a keyboard interaction or screen reader), these headers will either reveal or hide associated content.

I'm calling this 'appearing view' an accordion. I really hope that this doesn't upset too many readers of this development blog!

Something which looks something like this: [Images/out.gif](Images/out.gif)

# My process
I thought about having an animated view within a `UITableView`, but once I started to think about it (for the purposes of this blog at least) that felt a little like overkill. A better approach for me would be simply to hide a view and make it appear when the user taps 'more information' on the view.

I'm not going to use storyboards for this particular example, but to do the same in the storyboard is more than possible.

This is going to involve using [UIStackView](https://stevenpcurtis.medium.com/the-only-uistackview-guide-you-will-ever-need-a2bdd2a2258b), right?

# Difficulties
I guess forgetting how to use UIStackView is annoying.
Sure, the header with an image and a `UILabel` isn't so difficult

```swift
let headerStack = UIStackView(arrangedSubviews: [headerLabel, chevronImageView])
headerStack.axis = .horizontal
headerStack.spacing = 8
```

I'm then going to have a simple blue background as `moreInfoView`. I then nestle my `infoLabel` into this so I get a blue background. Note the height is set to 0 initially so we don't see this hidden view.

```swift
private let moreInfoView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    view.layer.cornerRadius = 10
    return view
}()

moreInfoView.addSubview(infoLabel)
infoLabel.translatesAutoresizingMaskIntoConstraints = false
moreInfoViewHeightConstraint = moreInfoView.heightAnchor.constraint(equalToConstant: 0)
moreInfoViewHeightConstraint.isActive = true
```

Then (oh yes then) it can be tricky to centre everything within a `mainStack. `moreInfoView` itself has been placed in the middle of the main stack so needs a width - I make it the same width as the enclosing stackview.

```swift
let mainStack = UIStackView(arrangedSubviews: [
    headerStack,
    moreInfoView,
    alwaysVisibleLabel
])
mainStack.axis = .vertical
mainStack.spacing = 16
mainStack.alignment = .center
mainStack.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(mainStack)
moreInfoView.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true
```

Note that I needed to center `infoLabel` if not it would not be in the middle of my `moreInfoView`.

```swift
NSLayoutConstraint.activate([
    infoLabel.centerXAnchor.constraint(equalTo: moreInfoView.centerXAnchor),
    infoLabel.centerYAnchor.constraint(equalTo: moreInfoView.centerYAnchor),
    mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
])
```

Please do forgive me, this all isn't production code. Just a possible approach to doing this.

# The Code
Here is the complete code:

```swift
final class ViewController: UIViewController {

    private var showMoreInfo = false {
        didSet {
            updateInfoVisibility(animated: true)
        }
    }

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "my text"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let moreInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        return view
    }()

    private var moreInfoViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        let headerLabel = UILabel()
        headerLabel.text = "More Information"
        headerLabel.textColor = .black
        headerLabel.isUserInteractionEnabled = true
        headerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleInfo)))

        chevronImageView.isUserInteractionEnabled = true
        chevronImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleInfo))
        )

        let headerStack = UIStackView(arrangedSubviews: [headerLabel, chevronImageView])
        headerStack.axis = .horizontal
        headerStack.spacing = 8

        let alwaysVisibleLabel = UILabel()
        alwaysVisibleLabel.text = "This has been here forever"
        alwaysVisibleLabel.textColor = .black
        
        moreInfoView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        moreInfoViewHeightConstraint = moreInfoView.heightAnchor.constraint(equalToConstant: 0)
        moreInfoViewHeightConstraint.isActive = true

        let mainStack = UIStackView(arrangedSubviews: [
            headerStack,
            moreInfoView,
            alwaysVisibleLabel
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
        moreInfoView.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true

        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: moreInfoView.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: moreInfoView.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        updateInfoVisibility(animated: false)
    }

    @objc private func toggleInfo() {
        showMoreInfo.toggle()
    }

    private func updateInfoVisibility(animated: Bool) {
        let newHeight: CGFloat = showMoreInfo ? 50 : 0
        let newAlpha: CGFloat = showMoreInfo ? 1 : 0

        let animation = {
            self.moreInfoViewHeightConstraint.constant = newHeight
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: self.showMoreInfo ? .pi / 2 : 0)
            self.infoLabel.isHidden.toggle()
            self.infoLabel.alpha = newAlpha
            self.view.layoutIfNeeded()
        }

        if animated {
            UIView.animate(withDuration: 0.25, animations: animation)
        } else {
            animation()
        }
    }
}
```

# Conclusion

That's my accordion view. I hope this has been of use to someone reading.
