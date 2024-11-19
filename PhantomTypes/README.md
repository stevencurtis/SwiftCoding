# Understanding and Using Phantom Types in Swift
## Give the Compiler Extra Data

Swift has a series of great features that can help us to write great code.

You probably love type safety as a great feature of Swift. We can leverage this usage by using phantom types, and this is especially useful in scenarios where states need to be explicitly modeled. 

So let's dive into this feature and see some examples about how this might work.

# What are Phantom Types?
Phantom types are type parameters that aren't directly used, but serve as markers to enforce compile-time constraints.

It's rather easier to take away with an example.

# An API Client Example
Imagine an API client where some operations require authentication. This state can be measured with phantom types to prevent accidentally sending unauthenticated requests, which is nice.

## The Phantom Types
The states of the request can be modelled with enum, but do not actually carry any data.
```swift
enum Unauthenticated {}
enum Authenticated {}
```

Using `enum` for phantom types is a great way to prevent misuse as it cannot be instantiated.

## A Generic APIRequest
Here the `APIRequest` features a `State` type parameter. This isn't used within the struct and will be used to represent whether the request is authenticated.

```swift
struct APIRequest<State> {
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
}
```

## Actions
We can then create an extension on API request. This is just for the example, obviously this does not currently truly authenticate the request.

```swift
extension APIRequest where State == Unauthenticated {
    func authenticate(with token: String) -> APIRequest<Authenticated> {
        APIRequest<Authenticated>(endpoint: endpoint)
    }
}
```

This method is only available when the State is Unauthenticated. After calling it, the method returns a new `APIRequest` instance in the `Authenticated` state.

We can create a `send()` method that only available for APIRequest instances in the Authenticated state.

```swift
extension APIRequest where State == Authenticated {
    func send() {
        print("Sending authenticated request to \(endpoint)")
    }
}
```

## Usage
We can then use this code to send our request and attempt to authenticate our request. We are unable to send from an unauthenticated request, which is the expected behaviour.

```swift
let unauthenticatedRequest = APIRequest<Unauthenticated>(endpoint: "/user/profile")
// This will not compile:
// unauthenticatedRequest.send()

let authenticatedRequest = unauthenticatedRequest.authenticate(with: "secureToken")
authenticatedRequest.send()
```

# Benefits of The Phantom Type Approach
**Compile-Time Safety**
You cannot call `send()` on an unauthenticated request because the compiler enforces the state constraints.

**Clarity and Intent**
The code clearly shows the transition from an unauthenticated to an authenticated state, reflecting the real-world workflow.

**Flexibility**
This design allows for additional states or transitions in the future, such as adding more detailed roles or permissions.

# Conclusion
By using phantom types, you can encode state-specific constraints into your request's workflow, ensuring correctness and clarity. This approach reduces runtime errors and makes your API interactions safer and more expressive. It's particularly useful in scenarios involving security, permissions, or any state-dependent behavior.
