# A StringBuilder for Swift
## You shouldn't do this

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2

I remember taking part in an interview where one of the interviewers asked which language I knew best. The answer?

```swift```

He followed up.

"No, which language do you know best. It's Ok, which one. I'm from a Java background."

It really trips up a candidate when an interviewer makes an assumption, and then makes a second assumption that you're so stupid that you don't understand the initial question.

# The Question
So his question wasn't about a `StringBuilder` Class, but the point is that for wider understanding it is worth knowing about the class in Java and the equivalents in Swift. This can aid communication with other programmers, which is never a bad thing.

# A StringBuilder in Java
In Java a `StringBuilder` is used to create a mutable collection of characters. The important property for `StringBuilder` is the fact that it is indeed mutable. 

This is in contrast to the `String` class in Java, which represents an immutable collection of characters.

In contrast to `StringBuffer`, `StringBuilder` is non-synchronized so the latter is more suited to a single rather than multiple thread. That is to say, `StringBuilder` is not thread-safe.

## The Declaration in Java, Constructors, and Methods
`StringBuilder` is part of `java.lang`

```swift
public final class StringBuilder

extends Object

implements Serializable, CharSequence
```

Constructors:
`StringBuilder()`
`StringBuilder(int capacity)`
`StringBuilder(CharSequence seq)`
`StringBuilder(String str)`

Methods:
`StringBuilder append (String s)`
`StringBuilder insert (int offset, String s)`
`StringBuilder replace(int start, int end, String s)`
`StringBuilder delete(int start, int end)`
`StringBuilder reverse()`
`int capacity()`
`void ensureCapacity(int min)`
`char charAt(int index)`
`int length()`
`String substring(int start)`
`String substring(int start, int end)`
`int indexOf(String str)`
`int lastIndexOf(String str)`
`Void trimToSize()`

## Where You Might Use A `StringBuilder` in Java
String Concatenations using `public String concat(String str)` copies the characters of the two strings in order to form the new string. This means the memory and runtime complexity is proportional to the length of the two input Strings. For two strings this is usually the better choice because only the result String is created.

The `+` operator is translated by the compiler to `StringBuilder` under the hood.
Where two Strings are joined this will translate to 
```java
new StringBuilder(strA).append(strB).toString();
```
meaning an extra `StringBuilder` instance is created. 

If multiple strings are joined, it is better to use the `+` operator 

```java
new StringBuilder(strA).append(strB).append(strC).append(strD).append(strE).toString();
```

# A Swift version
Yes. Hmm.

```swift
final class StringBuilder {
    private var value: [Character]
    init(_ string: String = "") {
        value = Array(string)
    }
    
    init(_ capacity: Int) {
        value = []
        value.reserveCapacity(capacity)
    }
    
    func append(_ string: String) {
        value.append(contentsOf: string)
    }
    
    func toString() -> String {
        return String(value)
    }
    
    func capacity() -> Int {
        value.capacity
    }
    
    func ensureCapacity(min: Int) {
        value.reserveCapacity(min)
    }
    
    func insert(_ offset: Int, _ string: String) {
        value.insert(contentsOf: string, at: offset)
    }
    
    func replace(_ start: Int, _ end: Int, _ s: String) {
        value.replaceSubrange(start...end, with: s)
    }
    
    func delete(_ start: Int, _ end: Int) {
        value.removeSubrange(start...end)
    }
    
    func reverse() {
        value = value.reversed()
    }
    
    func charAt(index: Int) -> Character {
        value[index]
    }
    
    func length() -> Int {
        value.count
    }
    
    func substring(start: Int) -> String? {
        guard start<value.endIndex else { return nil }
        return String(value[start..<value.endIndex])
    }
    
    func substring(start: Int, end: Int) -> String? {
        guard start<end else { return nil }
        return String(value[start..<end])
    }
    
    func indexOf(str: String) -> Int? {
        value.firstIndex(of: Character(str)) ?? nil
    }
    
    func lastIndexOf(str: String) -> Int? {
        value.lastIndex(of: Character(str))
    }
    
    func trimToSize() {
        value.reserveCapacity(value.count)
    }
}
```
Useful, I'm not sure. This doesn't provide any real benefit to those using Swift - but if you are working with Java experts perhaps it can smooth the communication between Swift experts and Java experts. Alternatively it gives you some idea about how Java is used in terms of methods and constructors.

# Conclusion
I hope that this article has been of some help to you.

I think the real-world use of this type of class would be to work with people how have never been exposed to Swift, but it has been fun to create in any case.

Let me know what you think, I love to get comments on my articles.

In any case, I hope this article has been of help to you.

Happy coding!

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
