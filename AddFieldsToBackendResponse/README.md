# Adding Fields To A Backend Response. What Will Happen? Swift Edition.
## The process

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 13.31, and Swift 5.6

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## Keywords and Terminology:
Bundle: A representation of the code and resources stored in a bundle directory on disk.

# The Idea
What happens when we add or remove fields from a backend response? What should you do about it.

Hint: We don't need to create a new App release in both cases.

# The Project
Imagine we have a backend which returns us a list of users and jobs. That is, an Array of people who each who have one or more jobs. 

A valid response would be:
```swift
[
    {
    "name": "Taylor Swift",
    "email": "taytay@bigmachine.com",
    "job": [{
      "role": "Singer",
      "industry": "Entertainment"
      }]
  }
]
```

This particular response only contains Taylor Swift, who is both a singer and an actor.

In Swift we often map this to a model.

I've decided to call this `PeopleModel`

```swift
struct PeopleModel: Codable {
    let name: String
    let email: String
    let job: [Job]
}

struct Job: Codable {
    let role: String
    let industry: String
}
```

This is using the rather wonderful `Codable` type alias of Swift.

For this example I'm going to read a static file. This means that we don't need to bother with setting up a complex backend for the App to interact with (which is nice), however, there is a complex extension in `Bundle-Decode.swift` which you can look through if you download the files from the repo.

So I've set up the project to read out the people from that file.

Something like the following:

```swift
let people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "People.json")
print(people)
```

Which (along with using a nifty extension on the `PeopleModel` to have a nice output) returns:

```swift
[Taylor Swift]
```

# So..Add people?
What will happen if we people to our json file?

Something like:

```swift
[
    {
        "name": "Donald J Trump",
        "email": "covfefe@gov.com",
        "job": [{
            "role": "President",
            "industry": "Politics"
        }]
    },
    {
        "name": "Taylor Swift",
        "email": "taytay@bigmachine.com",
        "job": [{
            "role": "Singer",
            "industry": "Entertainment",
        },
            {
                "role": "Actor",
                "industry": "Entertainment"
            }
        ]
    },
    {
        "name": "Aamir Khan",
        "email": "Aamir@Khan.com",
        "job": [{
            "role": "Actor",
            "industry": "Entertainment"
        }]
    },
    {
        "name": "Golshifteh Farahani",
        "email": "Golshifteh@Farahani.com",
        "job": [{
            "role": "Actor",
            "industry": "Entertainment"
        }]
    },
    {
        "name": "Kenneth Frazier",
        "email": "Kenneth@Merck.com",
        "job": [{
            "role": "CEO",
            "industry": "Pharmaceutical"
        }]
    },
    {
        "name": "刘亦菲",
        "email": "liu@hotmail.com",
        "job": [{
            "role": "Singer",
            "industry": "Entertainment"
        }]
    }
]
```

Now since we have an *array* with these people added there is no issue at all!

We now have the following console output:

```swift
[Donald J Trump, Taylor Swift, Aamir Khan, Golshifteh Farahani, Kenneth Frazier, 刘亦菲]
```

So that works perfectly!

# So..Remove a field?
What if our backend no longer returns email addresses. Imagine we would have a response like the following:

```swift
[
    {
        "name": "Donald J Trump",
        "job": [{
            "role": "President",
            "industry": "Politics"
        }]
    },
    {
        "name": "Taylor Swift",
        "job": [{
            "role": "Singer",
            "industry": "Entertainment",
        },
            {
                "role": "Actor",
                "industry": "Entertainment"
            }
        ]
    },
    {
        "name": "Aamir Khan",
        "job": [{
            "role": "Actor",
            "industry": "Entertainment"
        }]
    },
    {
        "name": "Golshifteh Farahani",
        "job": [{
            "role": "Actor",
            "industry": "Entertainment"
        }]
    },
    {
        "name": "Kenneth Frazier",
        "job": [{
            "role": "CEO",
            "industry": "Pharmaceutical"
        }]
    },
    {
        "name": "刘亦菲",
        "job": [{
            "role": "Singer",
            "industry": "Entertainment"
        }]
    }
]
```

Oh dear. There is a `keyNotFound` error here. The email key isn't in the response. You'll even get this if you remove the email from *any* of our people in the response. 

![Images/error.png](Images/error.png)

So, that's a crash! Disaster!

If you wanted the property to be optionla, of course you could. That is in the relm of *solutions* which this article isn't quite about.

# So..Add a field?
We can add a partner to our response. So if we had a single person returned in our array it might look something like the following:

```swift
[
    {
        "name": "Donald J Trump",
        "partner": "Melania Trump",
        "email": "covfefe@gov.com",
        "job": [{
            "role": "President",
            "industry": "Politics"
        }]
    }
]
```

Keeping the `PeopleModel` the same, that is:

```swift
struct PeopleModel: Codable {
    let name: String
    let email: String
    let job: [Job]
}

struct Job: Codable {
    let role: String
    let industry: String
}
```

We...run as before.

The console output is:
```swift
[Donald J Trump, Taylor Swift, Aamir Khan, Golshifteh Farahani, Kenneth Frazier, 刘亦菲]
```

We do need to remember that the partner property is not used in the model. So although we don't get a crash (yay!) we also are unable to get the property in our iOS Application.

# So..An App release?
If you wish to add a new property into a response, you will need a new release in order to process the property. However you will *not* generate a crash for your users who have yet to upgrade.

If you wish to *remove* a property you should be wary. Even if you create a new release (so your change does not crash all of your user's Apps) you may still have users who are yet to update. You could plan for this by using optional properties (this doesn't sound great), or by forcing users to update.

The story? Be careful about maintaining your API and what you plan to deprecate in the future. If you're removing a property you might be much better off creating a whole new API endpoint and over time deprecate your original one.

Getting complex for this article, isn't it?

# Conclusion
Be careful in removing properties from your BE. Less so about adding them.

So make sure you know what you're doing out there.

Good luck.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 

