# Understanding Method Dispatch in Swift
## class vs. struct

# Terminology
class: A reference type that supports inheritance and dynamic dispatch, allowing for shared instances and polymorphic behaviour.
struct: A value type that supports static dispatch and provides efficient independent resources
dynamic dispatch: A method resolution process where the method to be used is determined at runtime. Enables polymorphism and method overriding.
static dispatch: A method resolution process where the method is determined as compile time. This leads to efficient and predictable performance.

# Before We Start: class vs. struct
## Memory
class instances are allocated on the heap
struct instances are allocated on the stack
## Semantics
class instances use reference semantics. This means that multiple variables reference the same instance.
struct instances use value semantics. That means that stuct instances are copied when assigned to a new variable or passed to a function. This means that each instance is independent.
## Inheritance
class instances support inheritance, so subclasses can inherit and override methods from their superclass
struct instances do not support inheritance. They can adopt protocols, but inheritance is not supported.

# Method and Dynamic Dispatch
classes use dynamic dispatch or static dispatch (the latter if marked with final, and inheritance disabled)
struct instances use static dispatch 
## Static Dispatch
The method to be executed is determined at compile time. This is only possible as inheritance is not supported by value types (or classes marked with final)
## Dynamic Dispatch
The method to be executed is determined at runtime. This enables polymorphism and method overriding.
The are two types of dynamic dispatch: message dispatch and witness table dispatch. They operate in different contexts and leverage different underlying mechanisms.
## Message Dispatch
Message dispatch is used primarily in Objective-C (Core Data and KVO are users of this technology). Method calls are dispatched as a message to an object. This enables method swizzling leveraging the Objective-C runtime for method resolution.
When a method is called the message is sent to the object, which looks up the method implementation in its class and superclass hierarchy.
## Witness Table Dispatch
Swift uses protocol witness tables. This enables polymorphism through protocols and conformances.
When a protocol method is called on a type conforming to the protocol, the call is dispatched using a witness table that maps protocol requirements to the concrete implementations provided by the type.

# Advantages and Disadvantages
To round up here are the relative advantages of each method of dispatch.
- Static dispatch - fast execution, and even allows compiler optimisations like inlining
- Dynamic dispatch - flexible, and used for polymorphism. Swift supports table dispatch and message dispatch, although both are sadly less performant than static dispatch

#Conclusion
I hope this article has helped you out! Maybe I'll see you if you read the next one!

