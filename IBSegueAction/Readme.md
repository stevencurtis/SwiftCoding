# Use IBSegueAction To Make Storyboards Less Awful
## Use initializers

It's always good to make code better. If your codebase is using property injection I'd say it would be great to get rid of that and start using initialisers.

Since Xcode 11 we've been able to to do this using `@IBSegueAction`, but I noticed there are some guides saying you can't mix using `@IBSegueAction` and ordinary segues (not true!). So I thought I'd make an article about how they can be used and combined in a project!

Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
Be able to produce a "Hello, World!" SwiftUI iOS application

# Terminology
Segue: defines a transition between two view controllers in your app’s storyboard file
@IBSegueAction: An attribute that can be used to create a segue's destination view controller in code using a custom initilizer with any required values
Initializer injection: A form of dependency injection where dependencies are provided to an object via its constructor during the creation of the object

# Example of Segue
This is available on my repo, and in there is a folder "original".

Simply put, a view controller is linked to two others simply through modal segues (in a storyboard).

[Images/segue.png](Images/segue.png)<br>

Each of the `SecondViewController` and `ThirdViewController` have an integer that can be populated through property injection.

```swift
class SecondViewController: UIViewController {

    var myNum: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        print(myNum)
    }
}
```

This is populated through the ViewController.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "first" {
        let destination = segue.destination as? SecondViewController
        destination?.myNum = 2
    } else if segue.identifier == "second" {
        let destination = segue.destination as? ThirdViewController
        destination?.myNum = 3
    }
}
```

which is fine. Except how does the programmer know that the properties are set correctly? Could there be another property which is not used and is required for the relevant view controller to be used?

# The solution. Example of @SegueAction

The initilizer can be added to the relevant view controller. This is an failable initilizer, and is in this example view controller:

```swift
class ThirdViewController: UIViewController {
    var myNum: Int?
    
    init?(myNum: Int, coder: NSCoder) {
        self.myNum = myNum
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        print(myNum)
    }
}
```

Now to get this to work, we have to use a `@SegueAction` 

[Images/segueaction.png](Images/segueaction.png)<br>

This is a right-click on the segue which can then be command-dragged to the view controller. This provides a function. Which here I've called test and testTwo. `test` works as expected, passing the property in the initilizer for the `SecondViewController`. `ThirdViewController` shows that the process still works while we simultaneously use `prepare(for segue`.

But there is a question here. When we use both is the num on `ThirdViewController` set to 3 or 8?

```swift
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    @IBAction func buttonAction() {
        performSegue(withIdentifier: "first", sender: nil)
    }
    
    @IBAction func secondButtonAction() {
        performSegue(withIdentifier: "second", sender: nil)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first" {
        } else if segue.identifier == "second" {
            let destination = segue.destination as? ThirdViewController
            destination?.myNum = 3
        }
    }
    
    @IBSegueAction func test(_ coder: NSCoder) -> SecondViewController? {
        let viewController = SecondViewController(myNum: 7, coder: coder)
        return viewController
    }
    
    @IBSegueAction func testTwo(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ThirdViewController? {
        print(sender, segueIdentifier) // nil, second
        let viewController = ThirdViewController(myNum: 8, coder: coder)
        return viewController
    }
}
```

## Answering the ordering question
So is `@IBSegueAction` performed before or after `prepare(for segue`?

I won't leave you hanging for too long. The answer is `@IBSegueAction` is performed before `prepare(for segue` so in the code snippet 3 is number property is set to (in this case the property is set my initalization then reset through property injection).

I hope that's cleared that up!

# Conclusion
`@SegueAction` provides a way to ensure a more compile-time guarantee that required data is passed.

I've used it to stop using the dreaded property injection within my code.

If this helps just one person out this article will have been worth writing! Thank you for reading it.
