# Writing FIRST Swift Unit Tests
## Be a FIRST-class Developer!

![Photo by Nina Mercado on Unsplash](Images/photo-1599256871679-6a154745680b.jpeg)<br/>
<sub>Photo by Nina Mercado on Unsplash<sub>

# Terminology:
Unit test: Software testing where individual units or components of the software is Software testing where individual units or components of the software is tests

# Why test
Testing your classes is really important, giving confidence in your code and allowing programmers to both maintain your code (Good) and proof that your code meets the contract of what it should do.

When changes are made to code during development, breaking changes proves that code needs to be looked at again until all of the tests pass.

This is [Test Driven Development](https://medium.com/@stevenpcurtis.sc/test-driven-development-tdd-in-swift-b903b31598b6), but having FIRST tests actually goes further than that.

# What are FIRST tests?
* Fast
* Independent
* Repeatable
* Self-validating
* Timely

so let us dive in and see what each of these mean in turn:
**Fast**
Tests need to be quick, in such a such a way that developers won't be discouraged from using them. Developers won't run all the tests regularly if they take too long to run, and then what is the point in having them?

**Independent**
Tests should be independent of the state of the previous test. If you have a database that deletes a record, the next test shouldn't fail because that particular record is missing! In Swift we have the option of using `override func setUpWithError() throws` which runs at the beginning of each test to do any necessary prep work.

**Repeatable**
Repeatable means that tests do not depend on the environment that they belong in. If a test fails it is because the code that is running on that test fails, not a dependency and because another test is running at a similar time. The tests should always run with the expected output,

**Self-validating**
We are helped out with the way that the iOS SDK sets up tests for us, in that they either pass or fail. There should be no need for someone running the tests to understand how they are set up or how they run - either they pass or they don't.

**Timely**
Tests shouldn't be left until the end of a sprint, any production cycle or even when you have finished (in your opinion) your code. They should be written as and when they are useful to be run. Some will see this as an interpretation of [Test Driven Development](https://medium.com/@stevenpcurtis.sc/test-driven-development-tdd-in-swift-b903b31598b6), but it doesn't have to be. You should be writing tests to prove that your code is of sufficient quality for the job that it is performing. 

# Example
Watch the following video for my [SQLIteManager](https://youtu.be/qVu0ow0mats)

# Conclusion
Testing is important! As you move through your career this becomes more so - you never want to ship code that is anything less than excellent! In order to help you on your way, you might like to know about [TDD, ATDD and BDD](https://medium.com/@stevenpcurtis.sc/testing-differences-between-tdd-atdd-and-bdd-eeeeae862a2d) as well as the [theoretical testing of iOS apps](https://medium.com/better-programming/testing-ios-apps-beyond-the-basics-2d451766940c) and [Injection testing](https://medium.com/swlh/injecting-services-into-swift-apps-for-testing-39623f48941c).

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)