# Objective-C keywords in Swift
## Dynamic or synthesize

![Photo by CHUTTERSNAP on Unsplash](Images/photo-1534078362425-387ae9668c17.jpeg)<br/>
<sub>Photo by CHUTTERSNAP on Unsplash<sub>

## Terminology:
synthesize: In Objective-C, @synthesize automatically generates the getter and setter methods for a property declared in the class interface.
dynamic: The @dynamic keyword in Objective-C tells the compiler that the accessor methods for a property will be provided dynamically at runtime, often through the Objective-C runtime features.

# dynamic
@dynamic tells the compiler that the accessor methods are provided at runtime.

This is used to indicate that the accessor methods for a property (getter and setter) are implemented manually or will be provided at runtime, rather than being automatically synthesized by the compiler. This is often used in conjunction with runtime features or when integrating with other frameworks that require specific handling of property access.

```swift
final class MyClass: NSObject {
    @objc dynamic func exampleMethod() {
        print("Example Method")
    }
}

let myObject = MyClass()
myObject.perform(#selector(myObject.exampleMethod))
```

Here `exampleMethod` is exposed to the Objective-C runtime and so can be called dynamically using `performSelector`.

Dynamic can also be used for property observing.

```swift
final class MyObservableClass: NSObject {
    @objc dynamic var observableProperty: String = ""
}

let myObject = MyObservableClass()
myObject.observe(\.observableProperty, options: [.new]) { object, change in
    print("Property changed to \(object.observableProperty)")
}

myObject.observableProperty = "New Value"
```

Here, observableProperty is marked as @objc dynamic, allowing it to be observed for changes using Key-Value Observing (KVO) which is a feature of the Objective-C runtime.

# synthesize
@synthesize means that the compiler generates the getters and/or setters appropriate to match specifications given in the @property declaration.

```swift
@interface MyClass : UIView {
    NSString *_name;
}

@property (strong, nonatomic) NSString *name;

@end

@implementation MyClass

@synthesize name = _name;

@end
```

# dynamic and synthesize are mutually exclusive

Note that dynamic and synthesize are mutually exclusive.

This is because of their distinct roles in property behaviour management, and it simply would not make sense to use them together.

The mutual exclusivity arises because these two directives serve opposite purposes: @dynamic defers the method implementation to runtime, implying that the compiler should not generate these methods. @synthesize, however, explicitly asks the compiler to generate these methods at compile time. Therefore, applying both to the same property would result in conflicting instructions to the compiler: one asking not to create accessors and the other demanding their creation.

# property
@property means that the accessors will be created, and accessed with object message

```objective-c
@property (strong, nonatomic) NSString *name;
```

which means

```objective-c
- (NSString *)name;
- (void)setName:(NSString *)name;
```

# protocol
@protocol means that any property when conforming to a protocol won't automatically be synthesised

```objective-c
@protocol ProtocolName
@required
// list of required methods
@optional
// list of optional methods
@end
```

and we can conform to the protocol with 

```swift
@interface MyClass : NSObject <MyProtocol>
@end
```

# overridden properties
When you override a property of a superclass, you often need to explicitly synthesize it, especially if you are providing custom accessor methods or need a custom backing variable.

```objective-c
// Person.h
@interface Person : NSObject
@property (strong, nonatomic) NSString *name;
@end

// Person.m
@implementation Person
// Automatic synthesis of 'name' property
@end

// Employee.h
#import "Person.h"

@interface Employee : Person
@property (strong, nonatomic) NSString *name;
@end

// Employee.m
@implementation Employee
@synthesize name = _employeeName;

- (NSString *)name {
    return [NSString stringWithFormat:@"Employee: %@", _employeeName];
}

- (void)setName:(NSString *)name {
    _employeeName = [name uppercaseString];
}
@end
```

Which can then be used in Swift, providing the Employee class is exposed.

```swift
let employee = Employee()
employee.name = "Alice"
```

- The Employee class in Objective-C overrides the name property from the Person class.
- The Swift code creates an instance of Employee and interacts with the overridden name property.

So Swift code can interact with Objective-C classes (probably through a bridging header), including those with overridden properties.

# custom getters and setters
```objective-c
@interface MyClass : UIView {
    NSString *_name;
}

@property (copy, nonatomic) NSString *name;

@end

@implementation MyClass

- (NSString *)name {
    return _name;
}

- (void)setName:(NSString *)name {
    _name = [name uppercaseString];
}

@end
```

This can be accessed in Swift providing it is exposed (probably with a bridging header).

```swift
let myClassInstance = MyClass()
// Setting the name - this will use the custom setter in Objective-C
myClassInstance.name = "Hello"

// Getting the name - this will use the custom getter in Objective-C
let name = myClassInstance.name
```

# Autosynthesize getter and setter
When
```objective-c
@interface MyClass : UIView

@property (strong, nonatomic) NSString *name;

@end

@implementation MyClass

@end
```

This can be accessed from Swift.

```swift
let myClassInstance = MyClass()
myClassInstance.name = "Example Name"
```

# Conclusion
A property is really a getter and a setter, and is the gatekeeper for `Objective-C` usage. It's a window into how `Objective-C` interacts with Swift, and mastering its nuances can lead to more robust and flexible code.

I hope this article has been of some use to you, and I'd love to hear from you if it has.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
