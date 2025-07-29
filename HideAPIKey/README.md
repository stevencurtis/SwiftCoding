# How to Keep Your API Key Secret in a Swift Tech Test (and Still Use GitHub)

So you've been given a take-home tech test. We've all been there, finger hovering over the enter key to push to GitHub.
Then it occurs to you. You needed to use a API key to call the endpoint and you've left that in your code.
You risk not getting the job. You risk being that developer who leaves their key in a public repo.
You're going to need to handle this properly. You're going to need to guide your interviewer to be able to add their own API key.

# ✅ Step-by-step: Hiding your API key in a Swift project
Even if you've put the API key in a Constants.swift file, if it's committed, it's exposed.
Instead, we'll inject the key at build time.
1. 🛠 Create a `Secrets.xcconfig` file
In Xcode:
`File → New → File → Configuration Settings File`
Name it `Secrets.xcconfig` and save it in your project (not inside a .git-tracked folder if possible).

![config.png](https://github.com/stevencurtis/SwiftCoding/blob/master/HideAPIKey/Images/config.png)

Add your secret (for obvious reasons I'm not going to add my real key here):

```swift
API_KEY = real_api_key_here
```

# 2. 🔗 Link it to your build configs
Create `Debug.xcconfig` and `Release.xcconfig`.
`File>New>Configuration Settings File`

![configurationsettings.png](https://github.com/stevencurtis/SwiftCoding/blob/master/HideAPIKey/Images/configurationsettings.png)

Twice, once for the `Debug.xcconfig` file and `Release.xcconfig` 
Both file will have the same single line.

```swift
#include? "Secrets.xcconfig"
```

Which means load `secrets.xcconfig` if the file exists, and do nothing if it doesn't.

# 3. 🔧 Apply the configs to your targets
Click the blue project icon in Xcode's project navigator
Go to the Info tab
Under "Configurations", you'll see Debug and Release
Click each and select the appropriate `.xcconfig` file

![configurationsettings.png](https://github.com/stevencurtis/SwiftCoding/blob/master/HideAPIKey/Images/setdebug.png)<br>

![configurationsettings.png](https://github.com/stevencurtis/SwiftCoding/blob/master/HideAPIKey/Images/setrelease.png)

# 4. 💉 Inject into Target Properties
Open your `target>Info` and add

```swift
<key>API_KEY</key>
<string>$(API_KEY)</string>
```
![configurationsettings.png](https://github.com/stevencurtis/SwiftCoding/blob/master/HideAPIKey/Images/properties.png)

# 5. 🧑‍💻 Access in Swift code
I love to use `enum` for constants.
This prevents accidental instantiation, and is ideal for namespacing.

```swift
enum Constants {
    static let apiKey: String = {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY not set.")
        }
        return key
    }()
}
```

# 6. 📨 Send to GitHub
Create a `.gitignore` file in the root of your project folder. Add your `Secrets.xcconfig` file so it won't be uploaded.

7. ℹ️ Give Instructions
Tell your interviewer what to do! Namely:
Create a new file named:
`Secrets.xcconfig`
and add the following line to that file:
`API_KEY=your_api_key_here`

# Conclusion
Security starts in your first commit. Even in a tech test, keeping secrets out of your repo shows development maturity, and that has to be a good thing in take home test.
