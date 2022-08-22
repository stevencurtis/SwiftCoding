# Swift Swizzling
## Change the Implementation at Runtime

![Photo by Steven Welch](Images/photo-1471362229315-912f1caf95f7.jpeg)<br/>
<sub>Photo by Steven Welch<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.5, and Swift 5.2.4

# Terminology:
Runtime: The period of time where a program is running
Swizzling: Method Swizzling is the process of changing the implementation of an existing selector

Swizzling is called Monkey Patching in some languages, and this moves us towards understanding the attitude of the language feature. Furthermore, some people call it a hack or the nonsensical insult of an anti-pattern. 

We are going to explore how this can be used in Swift, and a real example of the use  

# Swizzling under the hood
Method Swizzling is about changing the implementation of an existing selector at runtime. This is performed through Swift's [Witness table]() and the mapping of the underlying functions contained within.

# The example project
## What we are trying to achieve
The idea is that this project swizzles [localizedString(forKey:value:table:)](https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring) and replaces the bundle path with a given alternative path. In effect, `NSLocalizedString` is pointed to a different set of localized Strings (for example, we could download a Bundle from an endpoint).

## The view of the implementation
Let us be honest here. There isn't too much going on in the project in this repo- the main screen of the ViewController just displays a `UILabel` and a `UIButton` (which doesn't have any functionality).

Where the project is interesting is throught the tests - if you swizzle the bundle the view controller will display one of two separate Strings.

## The tests
The tests use a simple helper function to reference a bundle of Strings from the Test Bundle (unfortunately here the word Bundle is used for both my Strings bundles and the test target).

As a result I've created the following tests:

```swift
class ViewControllerTests: XCTestCase {
    var sut: ViewController?
    override func setUp() {
        sut = ViewController()
    }
    
    func testInitialLabelValue() {
        // without method swizzling engaged we pull from the existing strings
        sut?.viewDidLoad()
        XCTAssertEqual( sut?.targetLabel.text, "Welcome Localizable.strings")
    }
    
    func testDownloaded() {
        // Strings from bundle
        sut?.viewDidLoad()
        MyLocalizer.swizzleMainBundle()
        XCTAssertEqual( sut?.targetLabel.text, "Welcome en.lproj in bundle")
    }

    func testBundle() {
        if let path = Bundle(for: type(of: self)).path(forResource: "BundleTesting.bundle", ofType: nil), let bundle = Bundle(path: path) {
            print (bundle)
        }
    }
}
```

## Swizzling
Here is the Swizzling function
```swift
class MyLocalizer: NSObject {
    class func swizzleMainBundle() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            if let path = Bundle.main.path(forResource: bundleName, ofType: nil), let bundle = Bundle(path: path) {
                return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
            }
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    if let origMethod: Method = class_getInstanceMethod(cls, originalSelector), let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) {
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
}
```

# Conclusion
Swizzling in this case means that we can choose to use a different bundle for our localization Strings. This is ideal in the situation where you may download localization strings from an endpoint server. This would be good (wouldn't it?).

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
