# Using SwiftUI Views with UIKit
## Callbacks too!

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

## The opportunity
We can use SwiftUI views and view controllers in our existing UIKit applications. This can be useful, since there is a feeling (and it might only be a feeling) that many resources and development are moving towards `UIKit`. It might make sense to start your migration early, and begin to think about how you can make your code `SwiftUI` compatible.

## The warning
SwiftUI can only be used with iOS13 and up. This means that you would need to drop support for iOS12 devices - and this is something perhaps you are not willing to do for a production App.

One solution for this can be the following:

```swift
if #available(iOS 13.0, *) {
    // use a SwiftUI view
} else {
    // fallback to UIKit
}
```

Anyway, on with the article!

# Add a SwiftUIView as a subview
I've got a rather attractive view with a purple background and a button. I want to represent this view as a subview in a `UIKit` ViewController - and process the button press from the parent view. Can I?

Let us take a look at the view:

```swift
import SwiftUI

struct PurpleUIView: View {
    var dismissCallback: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.purple
            Button(action: {
                self.dismissCallback?()
            }) {
                Text("Move on")
            }
        }
    }
}

struct PurpleUIView_Previews: PreviewProvider {
    static var previews: some View {
        PurpleUIView()
    }
}
```

we can see there is a callback `var buttonCallback: (() - Void)?` that we can access from the parent view.

So we set up a `UIKit` ViewController, which will have the following properties:

```swift
let swiftUIView = PurpleUIView()
lazy var hostingViewController = UIHostingController(rootView: swiftUIView)
```
so we are effectively wrapping the `PurpleUIView()` using `UIHostingController`, and we call this `hostingViewController`.

We can then effectively treat this like any other view, adding it as a subview using the `.view` property of our `hostingViewController`.
```swift
self.view.addSubview(hostingViewController.view)
```
and setting up constraints
```swift
hostingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding),
hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
```

we can set up the all-important button callback, and within those curly braces we can add whatever code we would like when the button is pressed!

```swift
hostingViewController.rootView.buttonCallback = {

}
```

# Navigate to a SwiftUI View from UIKit
I'm using a navigation controller here, and following on from the code above I can push a view controller when the user presses the button:

```swift
hostingViewController.rootView.buttonCallback = {
    let detailViewModel = DetailViewModel()
    let detailView = DetailView(viewModel: detailViewModel)
    let hostingController = UIHostingController(rootView: detailView)
    self.navigationController?.pushViewController(hostingController, animated: true)
}
```

So we are using the `UIHostingController` to make our `SwiftUI` view a `UIViewController`.

My example `DetailView` and `DetailViewModel` are represented as follows:

```swift
import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("This is entirely a SwiftUIView")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel())
    }
}



class DetailViewModel: ObservableObject {
    init() { }
}
```

# The other way
You can also access `UIKit` from `SwiftUI`! 

## Access a UIView from SwiftUI
A `UIView` can be accessed from a SwiftUI view. The `UIView` can be represented by a `UIViewRepresentable`, and as an example a `UIActivityIndicatorView` can be written as follows:

```swift
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        return view
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
}
```

which can then be used:

```swift
struct DetailView: View {
    var body: some View {
        ActivityIndicator()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
```

so when the `View` is displayed the `UIActivityIndicatorView` will display.

## Access a UIViewController from SwiftUI
It is possible to connect a `UIViewController`, in this particular case called `BasicViewController`. Now this needs to conform to `UIViewRepresentable`, essentially just wrapping this what I'm calling `CustomViewController`. Here are both of the classes shown here:

```swift
struct CustomViewController: UIViewControllerRepresentable {
    var message: String
    func makeUIViewController(context: Context) -> UIViewController {
        BasicViewController(message: message)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class BasicViewController: UIViewController {
    lazy var label: UILabel = UILabel()
    var message: String
    
    override func viewDidLoad() {
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        self.view.addSubview(label)
    }
    
    func setupComponents() {
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
}
```

which can then be accessed from one of SwiftUI's views, and the message property is passed so here is an example of this from a `View` called `ContentView`:

```swift
struct ContentView: View {
    var animals = ["🦒", "🦮", "🐖" , "🦔", "🦓", "🦢", "🦋"]
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(animals, id: \.self) { animal in
                        NavigationLink(
                            destination:
                                DetailView()
                        ) {
                            Text(animal)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarHidden(true)
                Button("Show View Controller") {
                    self.isPresented = true
                }.sheet(isPresented: $isPresented) {
                    CustomViewController(message: "Hello, World!")
                }
            }
        }
    }
}
```

# Conclusion
If you plan, or might plan to use SwiftUI for future iterations of your application you can save yourself migration time in the future.

Who wouldn't want that? I hope this article has helped you to move in that direction, if you so choose.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
