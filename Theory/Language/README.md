# Objective-C or Swift in 2022?
## There is one clear winner

![Photo by Kelly Sikkema on Unsplash](Images/photo-1520871942340-42898ab9167f.jpeg)<br/>
<sub>Photo by Kelly Sikkema on Unsplash<sub>

There has been much talk of the death of Objective-C, yet it is still possible to start a Project with Objective-C in 2022. Is this going to be something you want to do? Is it something you should do? Read and find out.

**Advantages of Swift**

Optionals
Error handling
Closures
Type safety
Speed - Almost as fast as C++
ARC
Dynamic library
Pattern matching
Swift playgrounds
Unified files
No pointers - So safer
Better memory management

**Advantages of Objective-C**
Interoperability with C++ and objective C++
Dynamic features like method Swizzling
A well-tested, stable language
Easy use of private APIs
Header and implementation files separate out interface from implementation
Fast compilation speed

**Disadvantages of Objective-C**
- Verbose syntax can be hard for beginners
- Lacks namespacing
- Explicit pointers can be confusing

**When to use Objective-C**
- If the App you are working on already uses Objective-C
- If C or C++ third-party frameworks are used extensively

**Performance**
Why? No dynamic dispatch.

Objective-C gets its object oriented nature by building a dynamic message based dispatch runtime. Every class method call gets sent to the ObjC runtime as a message, and that message gets passed on to the owning object to complete. This is a lot of unnecessary overhead. Granted, it gives some nice runtime features almost for free (swizzling, dynamic library injection, hooking, etc, these are doable in Swift/C but much more difficult, whereas they’re design features of ObjC)

Ultimately there are little nuanced things here and there where Obj-C wins on performance (i.e. String algorithms due to it still working with UTF-16 arrays of bytes instead of looking at strings as collections of extended grapheme clusters) but on the whole Swift has C-like runtime performance


# Conclusion
Is there a future for Objective-C? The quick answer is yes! Plenty of Apps have been created using Objective-C, and Objective-C is interoperable with Swift.

However, you really need to think about the problem that you are solving and pick the right tools for solving it. That should help you pick the language you need to use.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
