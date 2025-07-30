# Getting Started with Deep Linking in UIKit 🧭

Deep linking is a powerful way to route users to specific parts of your iOS app, whether from another app or from the web. In this quick tutorial, we'll go through setting up deep linking in a UIKit-based project with minimal boilerplate, making it easy to test and integrate into your app.

# Create a new UIKit project
Start by creating a fresh UIKit project in Xcode:
Open Xcode and choose "App" under iOS.
Name your project (e.g. DeepLinksProject), make sure to select Storyboard for interface and UIKit App Delegate for lifecycle.

# Handle the Deep Link in the SceneDelegate

Open the `SceneDelegate.swift` file and add the following method.

```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else { return }
    print("SceneDelegate received deeplink  URL: \(url)")
    // Handle auth callback here
}
```

This method will be called when your app is opened via a registered custom URL scheme.

# Add Your Custom URL Scheme

You need to register the URL scheme in the app. 
Register the URL scheme in your app:
Open `Info.plist`.

Add a new entry.

Key: URL types (`CFBundleURLTypes`)
Add a new item to the array.
Set URL Schemes (CFBundleURLSchemes) to DeepLinksProject (or whatever scheme you want to use).

![infoplist.png](https://github.com/stevencurtis/SwiftCoding/blob/master/DeepLinks/Images/infoplist.png)

It should look something like this in XML:

```
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>DeepLinksProject</string>
    </array>
  </dict>
</array>
```

# Test Your Deep Link
You'll need to run your project using the simulator. `⌘R` in Xcode should do the trick.
When the simulator is running, open up a Terminal window.
`xcrun simctl openurl booted 'DeepLinksProject://'`
You'll get a message on the simulator.

![opensmaller.png](https://github.com/stevencurtis/SwiftCoding/blob/master/DeepLinks/Images/opensmaller.png)

Click open and something like this should be printed in the Xcode console.

`SceneDelegate received deeplink URL: DeepLinksProject://`

# Conclusion
There are small pieces to do to get this working, but I hope this Medium post has helped the reader a little. Good luck coding!
