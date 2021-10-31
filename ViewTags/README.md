# Please do NOT use View tags in your Swift project
## Please?


The code for this article is stored right HERE
Never use them
The compiler does not enforce the use of unique tags. Worse, some programmers use tags in order to reference arrays of data in their code.
### You're doing it wrong
You can add tags to views in the storyboard
[Images/sbtag.png](Images/sbtag.png)
or you can do it programatically
```swift
let view = UIView()
view.tag = 0
```


now (for this example's sake) both have a tag of 0. One reason for choosing 0 for the example is that 0 is set in the storyboard if you do not choose to set any particular tag. That said, it is for this example only.

### Discovering the tag in views.

This can be done programatically, and for each of these we print out the tag.
```for subView in view.subviews {
    print(subView.tag)
}
```
Now in my example App I've included two UIView on the storyboard. Now guess the output - what do you think will happen?
```0
0
```
Both of the subviews in this case have the same tag. 0. We are relying on our programmer (or perhaps ourselves) to be good citizens and tag views with a unique identifier.

### Using tags to store data
Remember that some programmers are using tags to store data in their code? You might have an array

```
let data = ["A", "B", "C", "D"]
```

Then use the tag to reference to the data array when we use a gesture to detect touches on the object

```let gesture = UITapGestureRecognizer(target: self, action: #selector(logToConsole))
firstView.addGestureRecognizer(gesture)
````

which then references the following function
```
@objc func logToConsole(_ sender: UITapGestureRecognizer){
    print("The sender data  is : \(data[sender.view?.tag])")}
```
provided we can think to zero-index the tags when we give them those tags.

### The problems
The issue is that the tags are not unique to that object, and that when you use a tag to reference data you are creating a pointer to data that is not type-safe and which splits the data from the object. Not great.

### The solutions
**Uniquely identifying objects with ObjectIdentifier**
Objects such as views have a unique identifier already! That is, this is `ObjectIdentifier`, which you can access with code that looks something like `print(ObjectIdentifier(view))`.

### Passing data
Programmers often wish to find out which view has been clicked (for example), and for their code to act accordingly.
You'd like to use a tag to find out which UIView a user clicked, wouldn't you. You will almost certainly be using a subclass and able to add a property to your cell. That would be better than using the tag, certainly but aren't you already using a subclassed UIView? You probably are, and this technique can not only uniquely identify the view but also allow your code to act accordingly.

Something like the following subclassed UIView would help in this case!

```
class SubclassedView: UIView {
    var data: String?
    // init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    // init from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    // common setup code
    private func setupView() {
        backgroundColor = .green
    }
}
```

This data can then be set from within the view, and returned at any time:

```
let view: SubclassedView = SubclassedView()
view.data = "hello
print(view.data)
```

of course we can use initializers to start populate this data, or store some more complex type here but this simple example has been designed to vie you the rather basic idea of what might be done (rather than doing your programming job for you).

## Conclusion
So let us think about this
Don't store data in your view tag. Store data in properties instead, even if it involves subclassing

Think about compiler features which make your programming life easier. Tags can be changed over time, or views might get removed. Don't put yourself at risk and rather think about what you need to store, and why. This will give you more ability and flexibility in what might need to be changed in the future.

