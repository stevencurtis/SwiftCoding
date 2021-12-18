
# The UIPickerView Guide
## Not always as easy as it might seem

![Photo by Esther Wechsler on Unsplash](Images/0*D-0*lrzMbqpeu07gKseb.jpeg.jpeg)<br/>
<sub>Photo by Esther Wechsler on Unsplash<sub>

There are several ways to implement a `UIPicker` - and much depends on whether you choose to use storyboards, or whether you want to implement a `UITextView`. With that said, let us move on!


## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## Terminology:
UIPickerView: A view that uses a spinning-wheel or slot-machine metaphor to show one or more sets of values.

# The task
This article is about using a `UIPicker`, and display options for an Hour - Minute - Second format. Can't be too hard, right?

## The code (through the storyboard)
Setting up the `UIPicker` will require a `UITextField`, since the `UIPicker` will be the inputView of the `UITextField`.

We will setup this `UIPicker` from the `viewDidLoad()` function of the `UIViewController`.

```swift
  func setupPicker(){
      let pickerView = UIPickerView()
      pickerView.delegate = self
      textField.inputView = pickerView

      let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))

      toolBar.sizeToFit()
      
      let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
      toolBar.setItems([button], animated: true)
      toolBar.isUserInteractionEnabled = true
      textField.inputAccessoryView = toolBar
  }
```
To make sure that we don't get one of those annoying constraint broken messages, we set the initial frame of the `UIToolbar` as follows: `let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)).`

The code abover of course calls an `@objc` function that can be defined as the following:

```swift
@objc func done() {
    view.endEditing(true)
}
```

We then setup the following:

```swift
extension SBPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1, 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
    }
}
```

which sets up the `UIPickerViewDelegate` and `UIPickerViewDataSource`.

## The code (programmatically)
The  `UIPickerViewDelegate` and `UIPickerViewDataSource` are set up as above, but since the `UIPicker` is setup programatically (and the `UITextField`) we require a rather dashing `loadView()` function

```swift
override func loadView() {
    self.view = UIView()
    self.view.backgroundColor = .white
    setupTextField()
    setupConstraints()
    setupPicker()
}
```

which of course calls the following functions

```swift
func setupConstraints() {
    NSLayoutConstraint.activate([
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        textField.heightAnchor.constraint(equalToConstant: 34),
        textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
    ])
}

func setupTextField() {
    textField = UITextField(frame: .zero)
    textField.borderStyle = .roundedRect
    textField.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(textField)
}

func setupPicker(){
    let pickerView = UIPickerView()
    pickerView.delegate = self
    textField.inputView = pickerView
    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
    toolBar.sizeToFit()
    
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
    toolBar.setItems([button], animated: true)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
}
```

## The case without a UITextView
It is perfectly possible that you wish to use a `UIPicker` without a `UITextView`. This can be a little bit tricky, so let us press on with the storyboard version.

Now an option is to create a hidden `UITextView`. Well, yes, it is an option but not a particularly appealing one. Creating views that are not going to be presented and used on screen is not a particularly appealing task. We "must" be able to do better.


A second solution might be to add a `UIToolbar` as a subview for the `UIPicker`. Unfortunately 

```swift
var picker: UIPickerView!

override func viewDidLoad() {
    super.viewDidLoad()
    picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 260, height: 260))
    self.view.addSubview(picker)
    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
    toolBar.sizeToFit()
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
    toolBar.setItems([button], animated: true)
    toolBar.isUserInteractionEnabled = true
    picker.isUserInteractionEnabled = true
    picker.addSubview(toolBar)
}
```

now **unfortunately** you the touches seem to not be passed from the `UIPickerView` to the `UIToolbar`. Disappointing.

So to solve this problem we are going to need to `UIView` that the `UIPickerView` will live inside, as well as a `UIToolbar`. This should be...acceptable...

However, we need to animate the view appearing and disappearing, and can do so using the following code:

```swift
func appearPickerView() {
    UIView.animate(withDuration: 0.3, animations: {
        self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height - self.pickerView.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
    })
}

func disappearPickerView() {
    UIView.animate(withDuration: 0.3, animations: {
        self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
    })
}
```

So we can create a `UIView` as a container and ` UIPickerView`. We then structure `viewDidLoad()` as the following:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    pickerView = UIView(frame: CGRect(x: 0, y: view.frame.height + 260, width: view.frame.width, height: 260))
    self.view.addSubview(pickerView)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        pickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 260),
        pickerView.heightAnchor.constraint(equalToConstant: 260)
    ])
    
    pickerView.backgroundColor = .white
    
    picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
    self.pickerView.addSubview(picker)

    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
    toolBar.sizeToFit()
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
    toolBar.setItems([button], animated: true)
    toolBar.isUserInteractionEnabled = true
    picker.isUserInteractionEnabled = true
    pickerView.addSubview(toolBar)
    
    picker.delegate = self
    picker.dataSource = self
}
```

BOOM. A solution, and the full solution is in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/UIPickerView)

# Conclusion
`UIPickerView` is an extremely flexible component, and one that is useful for many situations when you are working on any particular iOS app. Require a guide about it? I think it's just been written.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
