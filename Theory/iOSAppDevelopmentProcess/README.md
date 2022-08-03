# The iOS App Development Process
## Software Development!

![Photo by Icons8 Team on Unsplash](Images/0*9AgkAHEdSRmLnlTL.jpeg)<br/>
<sub>Photo by Icons8 Team on Unsplash<sub>

There are a number of ways of 
* Planning
* Design
* Development
* Testing
* Launch and Maintenance

For the developer
* Gather requirements
* Design 
* Implement 
* Verify the solution

Yet these components for software development, when taken at face value seem rather small and trivial.
Let us move into more detail about the process that might go on when creating an iOS application.

# My process
**Requirements**
You can think of a rather large number of facets that can contribute to the requirements for a project.
In the first instance we can come up with a skeleton list of features.

**Compatibility**
Within the iOS world we can think of both devices and iOS version compatibility (although the two are interlinked) and this will impact the features (of Swift and the iOS SDK) that can be implemented at any given time. The orientation that the App should support needs to be planned in advance, and the probability that orientation changes may be changed in the future needs to be calculated.

**HCI (Human Computer Interface) guidelines**
Apple's HCI is incredibly important to follow. Apple have three primary themes that relate to iOS:
* Clarity
* Difference
* Depth

This is about the clarity and understanding from a user perspective in the application.

There are a number of design principles that should be applied to iOS apps.

* Aesthetic Integrity
* Consistency
* Direct Manipulation
* Feedback
* Metaphors
* User Control

**Understand the team**
* Where has the decision come from to implement this App (or features)? 
* The answer to this can often be the product manager, but for new products is there a single product manager? 
* Is there a single product or multiple products?

**User flow**
User flows help everyone to understand the higher level delivery of basic objects (for iOS often this often contains screens) that can represent the user's journey within the application.

The core user flow can contain important information for screens:

* What is the purpose of this screen?
* How can this screen help the user achieve their goal?

## Design
**Architecture**
The architecture of a new App, or the data flow of a new feature in an App is extremely important in that it gives us the structure of the application that can be built for future maintenance.

You may well be constrained in the choices that you can make, with architecture house-styles and justifications that need to take place in order to develop both your skills and negotiation skills.

**Wire framing**
Wire framing (also known as a page schematic) is essential and frequently when developed we do not produce designs for every possible screen size, rather we sometimes develop a wire frame for the middle screen.

In the early stages of a wireframe the goal is to set the visual hierarchy of layout and structure (taking into account that users often scan top to bottom and left to right, leading to an F-shaped reading pattern, but it should be noted that this is not the only scanning pattern available by any stretch).

It is important that designs follow the **HCI** guidelines and typical design patterns.

Zeplin is designed to bridge the gap between designers and developers and turn designs from sketch into design specs.

## Implementation
**Doing it!**
This is the point where iOS developers really shine. During a sprint developers get their work done, and produce features that deliver great user experiences.

**Refining**
* Animation and graphically intensive resources
* Data flow between screens

If an App is more complex, animations must be smooth (and complete before a new `UIViewController` has been popped onto the stack. Equally the flow of data needs to be managed through the different screens

* Performance

We should always be aware of the performance impact of animations and development of an App. Each well-crafted App should be optimized in terms of performance and memory footprint - if the performance is poor Apple may even decline to publish your App on the App Store!

* Data persistence

Thinking about how to cache data, how the App might persist between launches (and when the App is sent to the background) is arguably something that should not be left to a "refinements" section as this is tied into the overall design and architecture of the Application.

# Verifying the solution
It is important that any solution is verified as working, and delivers a good quality user experience.
## Manual
**Code review process**
Before any code is merged back into master, it must be reviewed by at least one peer. This ensures good code quality.

**QA**
The developer should ensure that their code is well tested, but in some setups they don't have access to a great number of devices (and that number might be zero!).

A QA team helps to look for bugs in both the features and functionality added, as well as some form of integration testing.

The solution should be tested against production data, and typically a QA team will have access to a number to test accounts (depending on the situation and setup of the organisation) to test against the production API.

**Unit testing**
A developer should test their code. This can be done through thorough unit testing, perhaps at the level of `70%` or even `80%`. Code without unit testing cannot be proved that it functionally *works*, and therefore unit testing through the public API should be implemented.

**UITesting**
MonkeyUI can take some of the drudgery out of manual clicking of buttons, and ensures that that the application does not crash. However, UITesting within Xcode has problems (for example when searching for elements through their visible strings) so this should not be the only method of testing a UI.

UITesting is extremely important, and cutting off labels for certain conditions isn't appropriate.

## Automated code review
**SwiftLint**
SwiftLint is a great way to conform to code style guides. It might be said that you should carry out your duties according to these design guidelines in any case, but still - we should live in the real world if we can.

**SonarQube and Fortify**
SonarQube reviews code, and provides reports around code coverage and other metrics around code quality. Fortify runs similar tests in terms of security impact of the solution.

## Automated testing
**Appium**
Appium can be integrated into the development pipeline. This means that each integration is verified by an automatic build. This enables us:

* Highly stable test suites
* Scalable simultaneous test devices and network conditions
* Test environments that can handle the security issues
* Rapid test results and developer actionable feedback
* To execute the tests from within Jenkins

# Conclusion
Developing Apps is really what this is all about!

You can develop yourself through the process of learning through doing, and developing competency for the future development of Apps.

Who wouldn't want that?

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)