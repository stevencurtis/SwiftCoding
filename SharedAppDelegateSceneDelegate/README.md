# Shared Initialization for AppDelegate and SceneDelegate
## Useful!

I recently looked at some of my old articles. Specifically I took a look at deleting the Storyboard in order to start a new project [this one](https://stevenpcurtis.medium.com/delete-storyboard-xcode-14-edition-5bb78c150ff5#:~:text=Get%20rid%20of%20the%20storyboard,file%2C%20and%20then%20press%20delete.).

I realised something that actually came up in a job interview a couple of years ago. If you wanted to support iOS versions prior to 13 you'd need to use `AppDelegate` and for iOS 13 and later you'd need to use `SceneDelegate`. How can we do this without unnecessarily repeating code?

I'll explain in this very project.

## Creating a new project
This is the normal routine. In Xcode choose `File>New>Project` and choose App.

[New Project](Images/newproject.png)<br>

The other options can be set to be the defaults.

[AppName](Images/appname.png)<br>

## Change the ViewController
We want to see if this code is working. I'll simply set the background colour of the view controller to purple. For fun I'll add the initilizer even though in this example I'm not using it at all.
So I think the following will suffice for this particular example.

```swift
import UIKit

final class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .purple
        self.view = view
    }
}
```

## Delete the Storyboard
In Xcode 14 you'll get a "free" file called `Main`. This is the storyboard but we won't need it.
Luckily we can use Xcode to delete it by selecting it on the left-hand side and then pressing delete on your lovely keyboard.

[select storyboard](storyboard.png)<br>

Make sure you delete by moving to trash (the reference isn't enough as the file would still be there).

[Trash the storyboard](trash.png)

## Remove Storyboard references
In `info.plist` there is a storyboard reference. We need to select that and then delete it.
I think that it's easier to show where this file is in an image rather than explain it.

[plist](plist.png)

## Create a new config file
We are going to create an AppConfiguation file that can be accessed from both the AppDelegate and SceneDelegate files.

In Xcode we can `File>New>File...` to create a new file. I've called this file `AppConfiguration`.

```swift
import UIKit

final class AppConfiguration {
    static func configureApp(for window: UIWindow?) {
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
```

## Access AppDelegate and SceneDelegate
Here are the full versions of `AppDelegate` and `SceneDelegate` that I'd suggest can be used in your project.

**AppDelegate**
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
           AppConfiguration.configureApp(for: window)
           return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
```
**SceneDelegate**
```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            AppConfiguration.configureApp(for: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

```

# Conclusion
As the iOS ecosystem evolves, developers are continuously presented with new challenges and opportunities for optimizations. The introduction of SceneDelegate alongside AppDelegate is a prime example. By leveraging a shared configuration strategy, we can efficiently handle app initialization across different iOS versions without redundant code. This approach not only streamlines the app setup but also paves the way for a more maintainable and scalable codebase. Whether you're starting a new project or refactoring an existing one, consider adopting this shared configuration mechanism. By doing so, you ensure that your app remains agile in the face of future iOS changes, all while promoting best coding practices.

I hope this article has helped someone out, and perhaps I'll see you at the next article?
