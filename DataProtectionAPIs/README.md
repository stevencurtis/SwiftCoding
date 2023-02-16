# iOS Data Protection APIs, Using Swift
## It's automatic, but you still need to know
Photo by Markus Winkler on UnsplashData Protection is a great API. It's so great because user data is encrypted, and the best part? Third-party Apps get this protection automatically! 

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

# Prerequisites:
You will be expected to be aware how to make a Single View Application in Swift, or the basic use of Playgrounds

# Terminology
Data Protection: A file and keychain protection mechanism for supported Apple devices. It can also refer to the APIs that apps use to protect files and keychain items.

# Why would we need data protection
It seems we have less and less control over our sensitive user data over time. This is possibly one of the causes of the phone hacking scandal in the UK, as celebrities made their date of birth and other information public (or the data was made public for them).
I'm sure you've secure data on your phone. You might even have [secure notes](https://support.apple.com/en-gb/guide/security/sec1782bcab1/web#:~:text=Secure%20notes,-Secure%20notes%20are&text=The%20note%20and%20all%20of,original%20unencrypted%20data%20is%20deleted.) to protect your musings from prying eyes using [AES](https://medium.com/@stevenpcurtis/aes-for-ios-developers-using-swift-8e9988cfb312). 
You really need to make sure that your App is also protecting your users from losing their important personal data
Apple have Data protection which is a system-level feature that provides encryption of sensitive data on the device.
File protection determines whether files can be read or written to. Which particular protection type you use depends on your needs (as well as the user).

# The file protection classes

## NSFileProtectionComplete
NSFileProtectionComplete is a file protection class in iOS that provides the highest level of data protection, and a class key is protected with a key derived from user passcode or password and UID. Once a user locks or in sleep mode a device the decrypted class key is discarded, rendering all NSFileProtectionComplete file unreadable (even to the system itself).
If you wish to store sensitive user NSFileProtectionComplete is the strongest of the iOS Data Protection APIs so can be used for private information, passwords (think carefully) and credit cards (although storing this in your App is an interesting design choice). The class NSFileProtectionComplete protection class is used by setting the NSFileProtectionKey attribute on a file when it is either created or modified.
Here's an example of creating a file with NSFileProtectionComplete protection in Swift:
```swift
import Foundation
let fileManager = FileManager.default
let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
let data = "secret data".data(using: .utf8)
try? data?.write(to: filePath, options: [.atomic, .completeFileProtection])
In this example, the file is created in the temporary directory with the name "sensitive.txt" and the NSFileProtectionComplete protection class is specified using the .completeFileProtection option when writing the data to the file.
```
## NSFileProtectionCompleteUnlessOpen
This is similar to NSFileProtectionComplete, but NSFileProtectionCompleteUnlessOpen some file may need to be written when the device is locked or the user logged out.
An email App may need to download an attachment in the background, but should only be able to access it when the App is open (in order to display it on screen). Once the App is closed the data protection is automatically reapplied.
This behaviour is possible by use of asymmetric elliptic curve cryptography and the per-file key is derived using a One-Pass Diffie-Hellman Key Agreement. The Agreement public key is then stored alongside the wrapped per-file key and SHA256 used as the hashing function. As soon as the file is closed, the per-key file is wiped from memory. To open the file again the shared secret would need to be recreated.
```swift
import Foundation
let fileManager = FileManager.default
let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
let data = "secret data".data(using: .utf8)
try? data?.write(to: filePath, options: [.atomic, .completeFileProtectionUnlessOpen])
In this example, the file is created in the temporary directory with the name "sensitive.txt" and the NSFileProtectionComplete protection class is specified using the completeFileProtectionUnlessOpen option when writing the data to the file.
```
## NSFileProtectionCompleteUntilFirstUserAuthentication

This is similar to NSFileProtectionComplete, but for the class NSFileProtectionCompleteUntilFirstUserAuthentication a file is unlocked the first time after booting. Once the file has been unlocked it can still be accessed even if the device is locked, as the class key has already been used to unlock the file. effectively this works the same way as NSFileProtectionComplete, except the decrypted class key isn't removed from memory when the device is locked (or the user logged out).
```swift
import Foundation
let fileManager = FileManager.default
let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
let data = "secret data".data(using: .utf8)
try? data?.write(to: filePath, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
In this example, the file is created in the temporary directory with the name "sensitive.txt" and the NSFileProtectionCompleteUntilFirstUserAuthentication protection class is specified using the completeFileProtectionUntilFirstUserAuthentication option when writing the data to the file.
```
## NSFileProtectionNone
This is the default protection level for iOS apps so usually wouldn't need to be explicitly set. Files encrypted with NSFileProtectionNone  with the UID only, and exists for remote wiping (where the class key is deleted leaving the data inaccessible) since the key is stored in effaceable storage.
```swift
import Foundation
let fileManager = FileManager.default
let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
let data = "secret data".data(using: .utf8)
try? data?.write(to: filePath, options: [.atomic, .noFileProtection])
```

# Conclusion
You might like to read the Apple documentation about these classes https://support.apple.com/en-gb/guide/security/secb010e978a/web but I hope this whirlwind article has been of some use to you.
As ever, happy coding!
