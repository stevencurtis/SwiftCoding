# Scaling iOS Software Development
## Considerations

![Photo by Dylan Gillis on Unsplash](Images/0*7qpsUAZ4Jrnx-9MR.jpeg)<br/>
<sub>Photo by Dylan Gillis on Unsplash<sub>

Some think of mobile development as Front-End Development, and developers working in the field don't need to consider scalability factors in their development.

Rather than limiting your career in this way, it would be much better to think about how your software can be scalable and support users well into the future. 

How might we do that?

# The architecture
Choosing a software architecture is essential not just for the development of software, but the maintenance and ease of adding new features in the future. There are many good reasons why [MVVM-C](https://medium.com/@stevenpcurtis.sc/mvvm-c-architecture-with-dependency-injection-testing-3b7197eb2e4d) has become so popular (particularly when a [factory is used for dependency injection](https://medium.com/@stevenpcurtis.sc/mvvm-c-architecture-with-dependency-injection-testing-3b7197eb2e4d)), but [VIPER](https://medium.com/swift-coding/the-viper-architecture-1a9dc140c505) shouldn't be underestimated (familiarities to Android development and alignment to TDD) just because of the massive gamut of files required for working software.

The decision needs to be made according to the software requirements, and the wider organisation and company culture that the software will be developed within.

# Coding practices
The organisation of a project is important ([such as folder organisation](https://medium.com/r/?url=https%3A%2F%2Fblog.usejournal.com%2Fhow-to-structure-your-folders-in-xcode-fbb1afa50bc7))

SwiftLint can help out during the development process, although there isn't anything that can replace having company-wide coding standards (and of course personal standards in development).

There are so many (so-called basics) that when implemented early on in software development make things easier, but when implemented late can be [rather more costly](https://medium.com/@stevenpcurtis.sc/technical-debt-in-coding-ff3a0a68f3b2). Put accessibility, scaling for device size and custom colors for dark mode within this category.

# Supporting legacy devices
For software that has a large number of users, the number of devices is perhaps the least of your potential issues. While many new features of the language and Xcode are revealed at any given year's WWDC, they are often only supported by the newest version of iOS - yet many users don't upgrade (not entirely true for Apple devices, but still a significant number) or have devices that don't support the latest version of the OS. For this reason, many software development firms have an n-2 strategy that supports not just the current version of iOS but 2 before it.

# Working across multiple teams
All of the things that are important for creating quality software. Documentation, and agile methods (stand-up, communication, etc.)

# Modularisation
The idea of microservices is that an application is envisioned as a collection of loosely-coupled services. By enacting the Single-Responsibility Principle services can be discretely developed in a way that improves fault-tolerance and bug crushing and smashing activities. By developing services separately a technology for the individual service can be chosen (rather than choosing a technology first and making it fit to the service that needs to be developed). Teams can be developed that are end-to end for the microservices in question, placing frontend, backend and database resources together in order to solve a problem.

This concept can be extended to micro Frontends for mobile. Vertical slices make up the user's application (this way of developing software is invisible to the end user),  and helps you to move away from monolithic codebases.

So what is an MFE? An MFE is a slice of an application, and can contain the services, UI and Business logic in order to implement a particular user journey. Each MFE can have it's own team working discretely from the other teams (although stand ups can combine multiple teams).

**Advantages**
* MFEs can be reused across applications
* Teams can focus on single MFEs, which can have their own release cycle discrete from the App release cycle
* Debugging should be easier, as each MFE contains discrete functionality
* Potentially MFEs can be written in either Objective-C or Swift (and any combination can be mixed) and there may be some scope for mixing architectures (although I wouldn't recommend this)

**Disdvantages**
* The organisation needs to be focussed on delivering MFEs and the functionality that they would deliver
* Where do shared resources belong? In the main application or in a particular MFE?

# Traffic spikes
Traffic spikes (for API calls) can bring down your backend server. Latency can be increased, and users may not be able to access their resource either.

Various events can cause traffic spikes:

* Product launches and promotions
* Load tests instigated either internally or by partners
* Real-life broadcasts of events (going viral!)
* DDoS, bots and scrapers

This can be mitigated through content delivery services (i.e. CloudFront). This offers:
* Caching
* Delivering content in the correct geographical area for the user (boosting the user's experience)
* Security

All while providing metrics and alarms for various states. 

It should be noted that CloudFront has dynamic or static content.

# Deployment scalability
You need to manage the release cycle in a scalable way. This means **automation** of tests and the pipeline. Did someone say Jenkins and SonarCube? I think they did.

# Testing and analytics
Testing at scale becomes important. Not only do users have a variety of different devices and operating systems, the combination of hardware profiles (including unpublished differences in hardware) which produces (you guessed it) bugs - something that effects 0.0001% of users suddenly becomes relevant and worth development time to fix. It really is better to make sure your code is stable and functional before release, then.

Don't forget languages either. You'll be supporting many more of those. Currencies? Perhaps the same.

# Conclusion
Working at scale is where we all want to be, producing great software and meeting customer needs. This article is about what that can mean, when you need to. When does that happen? That's the difficult part in startup culture.

Any questions? Please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
