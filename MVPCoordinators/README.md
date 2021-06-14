# The MVP iOS Architecture with Coordinators
## We can do better!


Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

# Prerequisites:
* You need to be able to create a new Swift project, and a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

# Terminology
MVC: Model, View and Controller
MVP: Model, View and Presenter

In my Previous article describing the MVP architecture, I created the Presenter in the View.

Now this is **Ok**, *fine* and *whatever*, but here we need to have the coordinator which is visible to the presenter. It is for this reason that we are creating the View from the presenter. 

This is based on my [flow coordinator](https://github.com/stevencurtis/FlowCoordinator) article, and [MVP article](https://medium.com/@stevenpcurtis/the-mvp-architecture-for-ios-e2be2f2469cc) goes into some detail about the Dependency Factory that is used with the implementation described below.

# The Reason for MVP
There a a couple of goals in using MVP in any particular project
## Separation of Concerns

# The Theory
The Presenter updates the View and reacts to User Interactions with the View. This means, by definition, the View must call methods on the Presenter.

The View must therefore have a reference to the Presenter, at the same time as the Presenter is required to have a reference to the View. 

This leaves an issue: which of the View and presenter should be created first (and which should create the other)?

In this implementation I've added to the `DependencyFactory`, created the presenter and then set the presenter within the view controller. See the code right here:

```swift
let viewController = MenuViewController()
let presenter = MenuPresenter(coordinator: coordinator, view: viewController)
viewController.set(presenter: presenter)
return viewController
```

The idea of the dependency factory is based around my [Flow Coordinators](https://stevenpcurtis.medium.com/flow-coordinators-using-swift-f45bd47b7a81) article, which might well make things seem a little clearer for the reader.

# The Implementation
## The Coordinator
The most interesting part of this implementation, is the ProjectCoordinator which takes care of the navigation for the project away from the View (in this project the View Controller):

```swift
func start(_ navigationController: UINavigationController) {
    let vc = factory.makeInitialViewController(coordinator: self)
    self.navigationController = navigationController
    navigationController.pushViewController(vc, animated: true)
}

func moveToDetail(withData data: String) {
    let vc = factory.makeDetailViewController(coordinator: self, data: data)
    navigationController?.pushViewController(vc, animated: true)
}
```

## The Factory: Creating the View Controller and Presenters
The DependencyFactory creates the View Controller and Presenters correctly to be used within the architecture implementation:

```swift
func makeDetailViewController(coordinator: ProjectCoordinator, data: String) -> DetailViewController {
    let viewController = DetailViewController(data: data)
    let presenter = DetailPresenter(view: viewController)
    viewController.set(presenter: presenter)
    return viewController
}

func makeInitialViewController(coordinator: ProjectCoordinator) -> MenuViewController {
    let viewController = MenuViewController()
    let presenter = MenuPresenter(coordinator: coordinator, view: viewController)
    viewController.set(presenter: presenter)
    return viewController
}
```

We set the view controller for the presenter in the initializer. Equally, use a function for the view controller to set the presenter - that is they both have references to each other.

## The View
We can take a look at the MenuViewController and MenuPresenter (the full code is in the repo), but the snippet here can be useful:

**MenuViewController**

```swift
class MenuViewController: UIViewController {
    let tableView = UITableView()
    var menuPresenter: MenuPresenterProtocol?
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(redView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        
        let exampleButton = UIButton()
        exampleButton.setTitle("test", for: .normal)
        exampleButton.translatesAutoresizingMaskIntoConstraints = false
        exampleButton.addTarget(menuPresenter, action: #selector(menuPresenter?.buttonPressed), for: .touchUpInside)
        self.view.addSubview(exampleButton)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            exampleButton.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            exampleButton.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
            exampleButton.heightAnchor.constraint(equalTo: redView.heightAnchor),
            exampleButton.widthAnchor.constraint(equalTo: redView.widthAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuPresenter?.showDetail(data: menuPresenter?.data[indexPath.row] ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuPresenter?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuPresenter?.data[indexPath.row]
        return cell
    }
}

extension MenuViewController {
    func set(presenter: MenuPresenterProtocol) {
        self.menuPresenter = presenter
    }
}

```

**MenuPresenter**
```swift
@objc protocol MenuPresenterProtocol {
    var data: [String] { get }
    func buttonPressed()
    func showDetail(data: String)
}

class MenuPresenter {
    let data = ["a", "b", "c", "d"]
    weak private var view: MenuViewController?
    private var coordinator: ProjectCoordinator?
    
    @objc func buttonPressed() {
        print("Button Pressed")
    }
    
    init(coordinator: ProjectCoordinator, view: MenuViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func showDetail(data: String) {
        coordinator?.moveToDetail(withData: data)
    }
}

extension MenuPresenter: MenuPresenterProtocol { }

```

## SceneDelegate
We set up the code in the SceneDelegate, this is done in the `willConnectTo session` function, although of course we need to also include a `UIWindow` property. In order to do so it is possible to replace the relevant function with the following:

```swift
var window: UIWindow?

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)

    let rootNavigationController = UINavigationController()        
    let container = DependencyFactory(dependencies: .init())
    let coordinator = container.makeInitialCoordinator()
    
    coordinator.start(rootNavigationController)
    
    window?.rootViewController = rootNavigationController
    window?.makeKeyAndVisible()
}
```

# The Code
There are quite a few files in this one!

We can take this file by file, and of course these files are in the accompanying repository!

## The Coordinators
The Project Coordinator conforms to two protocols, the AbstractCoordinator and the RootCoordinator,

Although child coordinators are not used in this particular project, it makes sense that this is included in this sample project:

**AbstractCoordinator**
```swift
protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
```

**RootCoordinator**
```swift
protocol RootCoordinator: AnyObject {
    func start(_ navigationController: UINavigationController)
}
```

**ProjectCoordinator**
```swift
class ProjectCoordinator: AbstractCoordinator, RootCoordinator {
    private(set) var childCoordinators: [AbstractCoordinator] = []
    // The reference is weak to prevent a retain cycle
    weak var navigationController: UINavigationController?
    private var factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AbstractCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    /// Start the coordinator, intiializing dependencies
    /// - Parameter navigationController: The host UINavigationController
    func start(_ navigationController: UINavigationController) {
        let vc = factory.makeInitialViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToDetail(withData data: String) {
        let vc = factory.makeDetailViewController(coordinator: self, data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
```

## The Factory
The DependencyFactory conforms to the Factory protocol:
```swift
protocol Factory {
    func makeInitialViewController(coordinator: ProjectCoordinator) -> MenuViewController
    func makeDetailViewController(coordinator: ProjectCoordinator, data: String) -> DetailViewController
}

class DependencyFactory: Factory {
    func makeDetailViewController(coordinator: ProjectCoordinator, data: String) -> DetailViewController {
        let viewController = DetailViewController(data: data)
        let presenter = DetailPresenter(view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    func makeInitialViewController(coordinator: ProjectCoordinator) -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(coordinator: coordinator, view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    struct Dependencies {
        // this can be used for Network Managers, and similar
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeInitialCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
```

## View
The view is represented by the View Controllers in this rather trivial example. Note that both of these View Controllers have a function to enable the presenter property to be set from outside the class.
**DetailViewController**

```swift
class DetailViewController: UIViewController {
    var detailPresenter: DetailPresenter?
    var data: String
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    init(data: String) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.textAlignment = .center
        self.view.addSubview(label)
        label.text = data
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension DetailViewController {
    func set(presenter: DetailPresenter) {
        self.detailPresenter = presenter
    }
}
```

**MenuViewController**

```swift
class MenuViewController: UIViewController {
    let tableView = UITableView()
    var menuPresenter: MenuPresenter?
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(redView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        
        let exampleButton = UIButton()
        exampleButton.setTitle("test", for: .normal)
        exampleButton.translatesAutoresizingMaskIntoConstraints = false
        exampleButton.addTarget(menuPresenter, action: #selector(menuPresenter?.buttonPressed), for: .touchUpInside)
        self.view.addSubview(exampleButton)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            exampleButton.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            exampleButton.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
            exampleButton.heightAnchor.constraint(equalTo: redView.heightAnchor),
            exampleButton.widthAnchor.constraint(equalTo: redView.widthAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuPresenter?.showDetail(data: menuPresenter?.data[indexPath.row] ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuPresenter?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuPresenter?.data[indexPath.row]
        return cell
    }
}

extension MenuViewController {
    func set(presenter: MenuPresenter) {
        self.menuPresenter = presenter
    }
}
```

## Presenter
There are two small presenters within this project, and they should contain the business logic for the views. 

**MenuPresenter**
```swift
class MenuPresenter {
    let data = ["a", "b", "c", "d"]
    weak private var view: MenuViewController?
    private var coordinator: ProjectCoordinator?
    
    @objc func buttonPressed() {
        print("Button Pressed")
    }
    
    init(coordinator: ProjectCoordinator, view: MenuViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func showDetail(data: String) {
        coordinator?.moveToDetail(withData: data)
    }
}
```

**DetailPresenter**
```swift
class DetailPresenter {
    weak var view: DetailViewController?

    init(view: DetailViewController) {
        self.view = view
    }
}
````

# Conclusion
That about wraps this up! Yes, it is rather a combination of two previous articles, however I hope it has been of help to you particularly if you are considering using MVP in order to implement your App,

What do you think? Do let me know!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)

