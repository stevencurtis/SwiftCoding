# Swift's JSONDecoder's ONE BIG MISS
## Handle TimeStamps from your Backend in Your Swift Application


![Photo by ME](Images/ThumbnailSwift.png)<br/>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

This article has a supporting video at:
[YouTube video](https://youtu.be/ecvQ0X1Maj0)

## Prerequisites:
* You just need to be able to create a Swift project, but it might help you to read over the [Date and Time Cheatsheet](https://stevenpcurtis.medium.com/dateformatter-date-and-time-cheatsheet-8bafaf4e0d2d)

# The background
You will almost certainly need to communicate with a backend through a published API. In fact, you might use an API like the [Twitter API](https://developer.twitter.com/en/docs/twitter-api) that is stable and well documented.

Now depending on why you are using an API, you might well have a date/time returned to you. 

Here is a snippet of data from a cursor-based API

```swift
{
  "data": [
    {
      "author_id": "1176828691365736451",
      "created_at": "2020-06-24T17:19:07.000Z",
      "entities": {
        "mentions": [
          {
            "start": 3,
            "end": 14,
            "username": "skipbolden"
          }
        ]
      }
```


## 2020-06-24T17:19:07.000Z ??

Yet this isn't the only format that dates can be. This article covers both the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard and [Unix Epoch Time](https://en.wikipedia.org/wiki/Unix_time).

What should be used and when?

# The brief alternatives
The Unix epoch (also Unit time, POSIX time or Unix timestamp) are the number of sections that have elapsed since midnight on January 1, 1970 (UTC/GMT). ISO 8601 is a calendar and clock format and represents a standardised way of presenting date and time (as well as time intervals).

# The problem to be solved
Mobile devices often need to display the time in the local time of the user. For example I want to check into a hotel at 3pm, and this must be 3pm *at the hotel*- irrespective of which country the backend server is in.

Yet the backend still needs to store the time. So how is this done?

## The backend
Since there is no format for dates in JSON, the output either needs to be a number or a string. This means the backend will present 

ISO 8601 is human readable, and has a specified timezone and enable reasonable sorting and comparison by front end developers.

Epoch on the other hand enables smaller payloads and is very familar for those from an embedded systems background. 

* How do you know the end user's timezone

You don't need to know! The frontend will know the timezone and can display the information to the user according to their geographic location and preferences. If something (like a notification) needs to be sent that displays the user's time the timezone identifier can be stored (but of course would need to be refreshed with the user's location when they change location across timezones)

* What format should be used to store a time in a database?
Databases are in the business of returning queries quickly. Integers are easy to query, index and are space efficient we often see times stored as  [Unix Epoch Time](https://en.wikipedia.org/wiki/Unix_time).

Using a local timezone would mean you assume your server is always deployed in the same timezone, and with AWS meaning servers can be quickly switched between regions (and even if you don't use AWS in the short term you might in the long term) making this an inadvised choice.

* How should you print usertime to the screen of the user? How can you convert a time to a local time?

We can do this in iOS! In fact this is what the rest of this article is about!

# The Implementation
## JSON Strings
Rather than creating a full backend API for this article, I've created two hard-coded JSON strings that can be decoded in a Swift Playground or MacOS command-line application.

## The Model
The model will conform to codable, and it would be great if we could store the data directly as a date object, so we shall do exactly that with the following model:

```swift
struct User: Codable {
    let user: String
    let timeStamp: Date
}
```
The `Date` type is independent of any time zone, so we can choose to make the data natively Swift by storing the date and making this change just once. This is independent from displaying the date on the screen.

I would usually split the data model into an APIdto where the timestamp coud be stored as an Int64, and a data object where it would be stored as a Data. However in this rather simple version storing the data as a Date will do!

## Data from Unix Epoch
The data can be decoded from the followingusing Swift:

```swift
let jsonStringUnixEpoch = """
{
    "user": "Noah",
    "time_stamp": 1616112000
}
"""
```

we do need to be careful of that [snake case](https://stevenpcurtis.medium.com/the-naming-conventions-you-must-to-know-2783d44b4a5e) and this can be converted as we set up the decoder with `.convertFronSnakeCase`.

```swift
let decoderUnix = JSONDecoder()
decoderUnix.keyDecodingStrategy = .convertFromSnakeCase
decoderUnix.dateDecodingStrategy = .secondsSince1970
if let data = jsonStringUnixEpoch.data(using: .utf8), let usersUnix = try? decoderUnix.decode(User.self, from: data) {
    print(usersUnix)
}
```

which would output the following:

```swift
User(user: "Noah", timeStamp: 2021-03-19 00:00:00 +0000)
```

Note that this isn't how you might output the date to the user, but for the console output this would be fine.

## Data from iso8601: The happy path
The data is stored in the following JSON string:
```swift
let jsonStringiso = """
{
    "user": "Noah",
    "time_stamp": "2021-03-19T09:37:20+0000"
}
"""
```

we can produce the following which, is perhaps not surprising to the reader:

```swift
decoderiso.keyDecodingStrategy = .convertFromSnakeCase
decoderiso.dateDecodingStrategy = .iso8601
if let data = jsonStringiso.data(using: .utf8),let usersiso = try? decoderiso.decode(User.self, from: data) {
    print(usersiso)
}
```

and we have a console output of the following:

```swift
User(user: "Noah", timeStamp: 2021-03-19 09:37:20 +0000)
```

## Data from iso8601: The likely path
Unfortunately we don't always have such a simple ride when using `.iso8601`.

That wrinkle is known as "milliseconds". 

If we have a new JSON `String` to decode (and it is perfectly viable that this might be returned from your backend):

```swift
let jsonStringisoMilliseconds = """
{
    "user": "Noah",
    "time_stamp": "2019-01-18T10:15:29.979Z"
}
"""
```

If you decode this using the same technique as above:

```swift
let decoderisoMilliseconds = JSONDecoder()
decoderisoMilliseconds.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMilliseconds.dateDecodingStrategy = .iso8601
if let data = jsonStringisoMilliseconds.data(using: .utf8), let usersMilliseconds = try? decoderisoMilliseconds.decode(User.self, from: data) {
    print(usersMilliseconds) // never executes
}
```

we unfortunately never print out the result. The `print(usersMilliseconds)` line is never executed.

Wait? What is going on?

Unfortunately the iso8601 format doesn't include the fractional settings. Perhaps what we should do is panic.

Or we can add our own date formatter:

```swift
extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601withSeconds: String { return Formatter.iso8601withSeconds.string(from: self) }
}

extension String {
    var iso8601withSeconds: Date? { return Formatter.iso8601withSeconds.date(from: self) }
}
```

we can then add in the date decoder strategy so we can use this with `Codable` which is, after all, what we intend to do here:

```swift
extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date in iso8601withSeconds: " + string)
        }
        return date
    }
}
```

which can then be used:

```swift
let decoderisoMillisecondsAttempt = JSONDecoder()
decoderisoMillisecondsAttempt.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMillisecondsAttempt.dateDecodingStrategy = .iso8601withSeconds
if let data = jsonStringisoMilliseconds.data(using: .utf8),let usersMillisecondsAttempt = try? decoderisoMillisecondsAttempt.decode(User.self, from: data) {
    print(usersMillisecondsAttempt)
}
```

which outputs the following to the console:

```swift
User(user: "Noah", timeStamp: 2019-01-18 10:15:29 +0000)
```

Unfortunately you'd need to only support from iOS11 onwards. Which you probably aren't. Which is a shame.

## The iOS9 version

```swift
extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date in iso8601withSeconds: " + string)
        }
        return date
    }
}

extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}

let decoderisoMillisecondsCustom = JSONDecoder()
decoderisoMillisecondsCustom.keyDecodingStrategy = .convertFromSnakeCase
decoderisoMillisecondsCustom.dateDecodingStrategy = .iso8601withFractionalSeconds
let formatter = ISO8601DateFormatter()
formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
if let data = jsonStringisoMilliseconds.data(using: .utf8), let usersMillisecondsCustom = try? decoderisoMillisecondsCustom.decode(User.self, from: data) {
    print(usersMillisecondsCustom)
}
```

We now get:

```Swift
User(user: "Noah", timeStamp: 2019-01-18 10:15:29 +0000)
```
and what is better is this works from iOS9!

# Conclusion
This article has gone some way to making those rather annoying dates a little bit easier to process.

While creating this article I found [EpochConverter useful](https://www.epochconverter.com), as well as a [JSON parser](http://json.parser.online.fr) and [Timestamp converter](https://www.timestamp-converter.com).

This has been further covered in my [YouTube video](https://youtu.be/ecvQ0X1Maj0) that explains some of this as well.

I hope this article has really helped you out!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
