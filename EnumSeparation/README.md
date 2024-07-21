# Using Enum Separation for Better Swift Code Organization
## Cope With a Large Enum

A large enum for handling various kinds of user actions seems like a great idea.
However large enums in Swift can be split up to enhance the structure and manageability of our code.
So let us look at the enum again:

```swift
enum UserAction {
    case login(username: String, password: String)
    case logout
    case signUp(username: String, password: String, email: String)
    case updateProfile(name: String, email: String, bio: String)
    case deleteAccount
    case follow(userID: Int)
    case unfollow(userID: Int)
    case post(message: String)
    case deletePost(postID: Int)
    case likePost(postID: Int)
    case unlikePost(postID: Int)
    case sendMessage(userID: Int, message: String)
    case deleteMessage(messageID: Int)
}
```

Sure, these enum values are all UserAction and they are all indeed user actions. 
However we should be able to split this up into smaller, more focussed enums.

# Splitting up the enum
Each of the values from the enum seems like a relatively simple task.
We get smaller, more focused enums for different actions:

```swift
enum AuthAction {
    case login(username: String, password: String)
    case logout
    case signUp(username: String, password: String, email: String)
    case deleteAccount
}

enum ProfileAction {
    case updateProfile(name: String, email: String, bio: String)
}

enum SocialAction {
    case follow(userID: Int)
    case unfollow(userID: Int)
}

enum PostAction {
    case post(message: String)
    case deletePost(postID: Int)
    case likePost(postID: Int)
    case unlikePost(postID: Int)
}

enum MessageAction {
    case sendMessage(userID: Int, message: String)
    case deleteMessage(messageID: Int)
}
```
Yet there is a problem. We might be able to handle the actions individually using something like this code:

```swift
func handleAuthAction(_ action: AuthAction) {
    switch action {
    case .login(let username, let password):
        print("Logging in with username: \(username)")
    case .logout:
        print("Logging out")
    case .signUp(let username, let password, let email):
        print("Signing up with username: \(username), email: \(email)")
    case .deleteAccount:
        print("Deleting account")
    }
}

func handleProfileAction(_ action: ProfileAction) {
    switch action {
    case .updateProfile(let name, let email, let bio):
        print("Updating profile with name: \(name), email: \(email), bio: \(bio)")
    }
}

func handleSocialAction(_ action: SocialAction) {
    switch action {
    case .follow(let userID):
        print("Following user with ID: \(userID)")
    case .unfollow(let userID):
        print("Unfollowing user with ID: \(userID)")
    }
}

func handlePostAction(_ action: PostAction) {
    switch action {
    case .post(let message):
        print("Posting message: \(message)")
    case .deletePost(let postID):
        print("Deleting post with ID: \(postID)")
    case .likePost(let postID):
        print("Liking post with ID: \(postID)")
    case .unlikePost(let postID):
        print("Unliking post with ID: \(postID)")
    }
}

func handleMessageAction(_ action: MessageAction) {
    switch action {
    case .sendMessage(let userID, let message):
        print("Sending message to user with ID: \(userID), message: \(message)")
    case .deleteMessage(let messageID):
        print("Deleting message with ID: \(messageID)")
    }
}
```

Yet that presupposes that we know which of the actions we are using from the callsite. That isn't great.

# The Interface
The solution is to provide an interface for handling all use actions, so we can create an enum that contains the specific actions.

```swift
enum UserAction {
    case auth(AuthAction)
    case profile(ProfileAction)
    case social(SocialAction)
    case post(PostAction)
    case message(MessageAction)
}
```

Which can then be used to handle the specific user interactions.

```swift
func handleUserAction(_ action: UserAction) {
    switch action {
    case .auth(let authAction):
        handleAuthAction(authAction)
    case .profile(let profileAction):
        handleProfileAction(profileAction)
    case .social(let socialAction):
        handleSocialAction(socialAction)
    case .post(let postAction):
        handlePostAction(postAction)
    case .message(let messageAction):
        handleMessageAction(messageAction)
    }
}
```

# Conclusion
I hope this article has helped you to break down enum in Swift a little. If not, just let me know in the comments! Thank you for reading!
