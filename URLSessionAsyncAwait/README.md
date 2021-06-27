# Use async/await with URLSession
## With a real example

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging<br>
This article has been developed using Xcode 12.5, and Swift 5.4

## Keywords and Terminology
async/await: An alternative to completion handlers, a coroutine model that allows execution to be suspended and resumed
URLSession: The class and related classes proved an API for downloading data to and from endpoints indicated by URLs.

# This article
## Background
I've got "Standard" use of URSession, using a view controller, view model and a closure to return the result.

Can I convert this to use Apple's new async/await? I sure can - and this adds a real example to the relevant [WWDC video](https://developer.apple.com/videos/play/wwdc2021/10132/).

The URL I'll be using is https://reqres.in/api/users?page=2, which is always a good site to use for example Apps requesting and returning JSON.

Note that each of these projects only do one thing. That is, they both write the result to the console (there is no exciting UI here, I'm afraid!).

## The standard project
Note here that I'm using a closure to return the result of the request from URLSession. 

I wouldn't say that this approach is necessarily error-prone, but equally newcomers to the Swift language can find this rather hard to use and to work with. 
**View controller**
```swift
class ViewController: UIViewController {

    var viewModel: ViewModel
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.closure = {
            print($0)
        }
        
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}

        viewModel.retrieveUsers(from: url)
    }
}
```
**View Model**
```swift
class ViewModel {
    init() { }
    
    var closure: ((Users) -> Void)?
    
    func retrieveUsers(from url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decoded = try? decoder.decode(Users.self, from: data) {
                self?.closure?(decoded)
            }
        })
        task.resume()
    }
}
```

## The async/await project
**View controller**
```swift
class ViewController: UIViewController {

    let viewModel: ViewModel
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}

        async {
            let users = try? await viewModel.retrieveUsers(from: url)
            print(users)
        }
    }
}
```
**View Model**
```swift
class ViewModel {
    init() { }
    
    func retrieveUsers(from url: URL) async throws -> Users {
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Users.self, from: data)
    }
}
```

# Conclusion
I hope this article has been of help to you! It has been designed to accompany Apple's WWDC video

The idea of this particular article has been to give you at least one practical example. To really do so, I'd recommend you take a look at the repo: https://github.com/stevencurtis/SwiftCoding/tree/master/URLSessionAsyncAwait
If you've any questions, comments or suggestions please hit me up on Twitter
