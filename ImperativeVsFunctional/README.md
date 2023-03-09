# Imperative vs. Functional Swift Programming
## What are they? Which should you use?

This article contains content [previously published](https://stevenpcurtis.medium.com/imperative-vs-declarative-swift-programming-7e3c77309f76) on Medium

Difficulty: Beginner | **Easy** | Normal | Challenging

This article is best used in conjunction with the Swift Playground https://github.com/stevencurtis/SwiftCoding/tree/master/ImperativeVsFunctional

# Prerequisite Articles:

- [Coding in Swift Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) will help you be able to use the playground available for you to [download](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fstevencurtis%2FSwiftCoding%2Ftree%2Fmaster%2FImperativeVsFunctional)
- [Using SwiftUI in Playgrounds](https://medium.com/@stevenpcurtis.sc/using-swiftui-in-a-playground-4f8a74181593) will help you use Playgrounds with SwiftUI
- Map is used within the article, as are [Arrays](https://medium.com/@stevenpcurtis.sc/the-array-in-swift-d3e0fb04a0dd) and [for loops](https://medium.com/swlh/for-loops-in-swift-628a6a2b2ea7)

# Terminology
Functional programming: a programming paradigm which uses statements to change state
Imperative programming: a programming paradigm which expresses the logic of a computation without describing the program flow

# Imperative Programming
An `Imperative` programming paradigm is a common approach which programming using Swift as the language.
It can be thought of as telling the machine how to do something step-by-step, which then outputs the result. This is a traditional way of programming computers, and can be thought of like a recipe for your favourite dish in that there are series of steps to be followed.

# Functional Programming
In contrast, a Functional (a `Declarative` programming paradigm)  style is built upon formal logic, describing *what* a program must accomplish rather than how.
That is not nearly as complex to achieve as it might appear, and this article will help out with some examples.

# Arrays: An example
An `Array` is a data type, and therefore a means for a programming language to interpret some values.
If we wish to store a series of numbers, an `Array` would certainly be a good choice of doing so.
Using our target language of Swift, an `Array` array called `arr` can be declared using the following code:

```swift
let arr = [1,2,3,4,5]
```

and let us assume we wish to create a new array with the same elements as `arr`, but doubled.

# The Imperative Example

A good approach to this is to walk along the length of the array, taking each element of the array arr and doubling it before adding it to a new array called output.

```swift
var output: [Int] = []
for i in 0..<arr.count {
    output.append(arr[i] * 2)
}
```

Here we create the `output` array. We then set up a variable called `i` which increases from 0 to length of the array minus 1 (this is because arrays are [zero-indexed](https://medium.com/swlh/zero-indexed-arrays-f752a47abf65)).

# The Functional Example
We can use a higher-order function to apply a function repeatedly to the elements of an array. This is a [map](https://medium.com/@stevenpcurtis.sc/mapping-in-swift-a6d6132a38af), and is an example of functional coding when we apply a doubling of each element in the array `arr`

```swift
let output = arr.map{ $0 * 2 }
```

Here the `map` function creates a new array, where each element in the new array is created by passing each element in turn into the function passed to map (i.e. `$0 * 2`).
So the `map` function can be through of how the computation should perform, and the `map` function itself deals with the iteration and state management - we specify what we are looking for by providing the `map` function with a function to run (if that makes any sense, which it almost certainly doesn't).

*Want the code?*

If you're downloading the repo `ImperitiveFunctional.playground` has you covered here, and you can look at the code to see how this is done for yourself.

# UIKit vs. SwiftUI
Each of these display a particular `Array` of Strings ("1", "2", "3", "4" and "5") and displays them in a table.
We can now present two examples, one of imperative and one of functional coding. Let's take a look:

## Imperative coding
No funny business here using a `UICollectionView`, rather this is a simple table using a `UITableView`. There is some stuff going on around registering cells, but I hope that this code is reasonably easy to understand and work out for the reader.

```swift
import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let strings = ["1", "2", "3", "4", "5"]
    var tableView : UITableView!
    
    override func loadView() {
        self.tableView = UITableView()
        self.view = tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = strings[indexPath.row]
        return cell!
    }
}

// set the view and indefiniteexecution
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = MyViewController()
```

For those downloading from the repo, `UIKitTable.playground` is the one that you would want! We can think of UIKit as `Imperative` coding, we are presenting a series of instructions which end up with the `Strings` being presented in the `UITableView`.

## Functional coding
For this example we use SwiftUI, and the List Struct in order to present the same strings in the form of a table. SwiftUI does not require us to register cells or present information in the same way.

```swift
import UIKit
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    let strings = ["1", "2", "3", "4", "5"]

    var body: some View {
        List(strings, id: \.self) { string in
            Text(string)
        }
    }
}

let viewController = UIHostingController(rootView: ContentView())

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
```

For those downloading from the repo, `SwiftUIList.playground` is the one that you would want! We can think of SwiftUI as Declarative coding.

# Which Should Be Used?
A programming paradigm shouldn't be approached as a simple either-or question as in fact they can be mixed in the same Swift codebase. In fact you should always look at your coding environment (the business and the programmers you are working with) rather than focussing on technical requirements.

Functional programming should eliminate race-conditions, and improve testability. However, it rather does depend on your codebase the problems you are trying to solve. It can be said that imperative is a familiar way of programming to many coders, and those workers should be at the fore of your mind when thinking of which technical solution to deploy.

# Conclusion
Whether you are new to functional programming or wish to understand the difference between functional and imperative code, I hope this article has been of use to you.
Happy coding!

If you've any questions, comments or suggestions please hit me up on Twitter

Subscribing to Medium using this link shares some revenue with me, or perhaps you'd be so kind as to make a donation to me using [https://www.buymeacoffee.com/stevenpcuri](https://www.buymeacoffee.com/stevenpcuri).
