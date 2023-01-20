# Avoid Nesting Functions in Swift
## Not harmless at all!

![Photo by bruce mars on Unsplash](Images/0*EBkF0cdM-T7l8tWh.jpeg)<br/>
<sub>Photo by Jan Meeus on Unsplash<sub>

# Prerequisites:
* You will need to be familiar with the basics of [Swift and able to start a Playground (or similar)](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
* You should know something about [weak references](https://medium.com/@stevenpcurtis.sc/swift-self-weak-or-unowned-7e2327974f36)

# Terminology:
Function: a group of statements that together can perform some action

# Background
One of the things about completing [LeetCode Challenges](https://github.com/stevencurtis/SwiftCoding/tree/master/LeetCode/Contests) is that completing them helps you to explore the limits of your chosen language (in this case, we are talking about Swift).

Now one of the challenges that seems to re-emerge when completing these contests is using a Binary Search (an example of this is challenge [1552](https://leetcode.com/problems/magnetic-force-between-two-balls/)) which asks the programmer to develop a Binary Search but with a custom function to decide whether we look to the left of the right of mid point.

```swift
class Solution {
    func maxDistance(_ position: [Int], _ m: Int) -> Int {
        let position = position.sorted()
        let length = position.count
        
        func ballsWillFit(_ d: Int) -> Int {
            var result = 1
            var cur = position[0]
            for pos in position where (pos - cur) >= d {
                cur = pos
                result += 1
            }
            return result
        }
        
        var left = 0
        var right = position[length - 1] - position[0]
        while left < right {
            let center = right - (right - left) / 2
            if ballsWillFit(center) >= m {
                left = center
            } else {
                right = center - 1
            }
        }
        return left
    }
}
```  
Now this might trip up the inexperienced developer. Let us look at the function `ballswillFit(_ d: Int) -> Int`:
```swift
func ballsWillFit(_ d: Int) -> Int {
    var result = 1
    var cur = position[0]
    for pos in position where (pos - cur) >= d {
        cur = pos
        result += 1
    }
    return result
}
```
We can see that we are passing the parameter `d` into the function - but notice that the `Array` `position` is also used - without being passed as a parameter - neat right?

That, right there is what makes nested functions GREAT. Although, there should be a list of advantages. Strap in...

# The advantages
It is important to recognise that you are creating a function that can only be accessed from within the parent function. Other developers will **not** be able to use this function (and obviously there is a testing implication for this). When the function is called it is clear what is the calling function, and this will always be called by this parent function. 

The lifecycle of your function is identical to that of the parent function, it will be released at exactly the same time so there is no danger of memory leaks. 

# The rules: part 1
It is important to realise that we need to (as in the example above) declare our `function` before using it. That is, declare the `function` before before using it - you know, like usual!

# The rules: part 2
THIS IS IT! You start to think that nested functions are the way to go.

Then you get into a mess. 
```swift
class Test {
    var name: String
    init(name: String) {
        print ("init")
        self.name = name
    }
    func testFunc() {
        func test() {
            print ("test", name)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            test()
        }
    }
    
    deinit {
        print ("deinit called")
    }
}

var test: Test? = Test(name: "test")
test?.testFunc()
test = nil
```

Output
```swift
Allocated
test test
deinit called
```

This means that the `class` is only deallocated once the print it called - that is there is a `Strong` reference to self here.

**But there is no warning from the compiler about this**.

What if you want to create a **weak** reference to self? No problem!

```swift
class Test {
    var name: String
    init(name: String) {
        print ("init")
        self.name = name
    }
    func testFunc() {
         weak var _self = self
        func test() {
         print ("test \(_self?.name)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            test()
        }
    }
    
    deinit {
        print ("deinit called")
    }
}

var test: Test? = Test(name: "test")
test?.testFunc()
test = nil
```

Output
```swift
init
deinit called
test nil
```

Of course this will only be an issue if you use instance variables in your nested function - if not, you have the option of **not** using nested functions at all. 

# Conclusion
There isn't anything wrong with nesting functions in Swift; they are another wonderful feature of the language. 

However, you need to ensure that you understand **why** you might want to use this feature, and of course understand the impact of using this feature.

I hope you feel that this article has given you some guidance and support in making those decisions in your coding journey.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
