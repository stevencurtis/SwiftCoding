# Upgrade to Semantic Versioning
## Handle Major and Minor upgrade smoothly

![Photo by Alvan Nee on Unsplash](Images/0*uKY1mjMGEK-sAro8.jpeg)<br/>
<sub>Photo by Alvan Nee on Unsplash<sub>

Semantic versioning is a formal convention for specifying compatibility using a three-part format.

# The format
This format can represent any version of software, say version 2.5.4
Here we have three periods . that split up the three parts of the version number.
Major . Minor . Patch
so 2.5.4 is represented the same way
2 (Major) . 5 (Minor) . 4 (Patch)

## Patch
The patch number should be incremented when (say) a bug is fixed or some other work (refactoring?) has taken place that neither breaks APIs or adds features to the software.

## Minor
Developers increment the minor version number when features are added to the software by APIs are not broken.

## Major
Developers increment the major version number when public APIs of the software are changes. Major versions can (and often do) feature breaking changes.

# Understanding the consequences
If you are using third-party dependencies you should be able to specify the version of that software that you are using. In order to do so you could specify the whole version - say 2.5.1 - and never update from there. 

This may seem sensible as it means that your software will never break using that verison of your dependency. However there are real problems with doing this - namely, what if the developer makes some important bug fixes?

So perhaps you wish to just have your version of the software match in-step the version that the developer of the dependency has released. The problem with this is that they might release a new *major* version of the software that could break your software - since the API has changed (potentially) this might take some time to fix - and worse it might happen at any time (as you aren't in control of the releases of the dependency.

You might have (then) guessed that there is one potential solution for this problem. Yes, you guessed it; you are safe updating the minor version but not the major version updates!

Semantic versioning has come to our rescue for giving a formal way of versioning software.

# Designating development stage
There are three parts for semantic versioning, but sometimes you might wish to indicate the development stage of software. The solution? Add an extra number to the beginning of our format.
The meaning of these numbers are as follows: 0 - alpha, 1 - beta, 2-release, 3-finalrelease
a 4-part version might look like the following:

4.3.5.2


# Conclusion
Understanding semantic versioning (or SemVer) is an important thing to understand when you are developing software, and this article has given you a reason why you should care about this. 

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
