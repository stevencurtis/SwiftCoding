# iOS Developers Should Avoid These 5 Common Mistakes
## We've all made them

##Memory management
We all want to avoid user frustration when creating our Apps. Retain cycles can cause crashes and slow performance for the end user, none of which is good to say the least. Instruments is a great tool to track these issues in existing (or new!) code.
In the following code (in a Playground, or similar) deinit isn't called for either the Tutorial or Student class. The reason? It's a memory cycle.

```swift
class Tutorial {
    private var students = [Student]()
    func enroll(_ student: Student) {
        students.append(student)
    }
    init() {
        print ("Tutorial initialized")
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

class Student {
    private var tutorial : Tutorial
    private var name : String
    init(tutorial: Tutorial, name: String) {
        print ("Tutorial initialized")
        self.tutorial = tutorial
        self.name = name
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)

computing = nil
dave = nil
```

## Not testing on real devices
Testing on real devices ensures that iOS Apps provide that great user experience for real users. Simulators are very useful, but use the power of your desktop machine rather than the real-world limitations of a portable device (in terms of hardware and networking).
Compatibility issues can occur on different devices due to hardware differences, and need to be investigated to make sure all users have a great experience.
It has always surprised me that development members of staff are seldom given i-devices by employers. You need to buy your own seems to be the refrain, yet to do a great job you'll need a variety of devices.
I guess employers would point to services like Apple's TestFlight for distributing beta versions of Apps to users so they can test on their device, Sauce Labs or Amazon's device farm. I'd say these are secondary, and the developer should be the first line of defense for bugs and issues that can come out of development.

## Ignoring the User Interface
The idea that the interface is completely down to your designers can really impact the success of an application. Negatively. Specialist platform-specific information can come from individual developers and can make all of the difference to the end user.
Unappealing, cluttered or confusing designs (particularly during signup flows) can turn users away or cause them to abandon an App. It should be down to the developer to help the design team to create appropriate and effective interfaces. Beautiful designs are not only functional but are enjoyable to use, and it is this sense of enjoyment and user satisfaction which makes successful Apps!
## Not prioritizing accessibility
Accessibility can be an afterthought at many software development houses. It is even possible to describe accessibility using discriminatory language which goes to show how much of a battle developers have in creating accessible applications.
Accessibility is not just about removing permanent barriers to people accessing content. It is about anybody being able to use accessibility features in order to access content, and conducting user testing with those who use accessibility tools can raise issues with the code and mean your application is accessible to all!
Skipping the App Store Review Guidelines
Ever thought you'd 'get away' with an App that doesn't follow Apple's guidelines. Although some do slip through, those guidelines often result in rejection from the review process.
Looking through the guidelines and understanding what Apple want from developers is a great start. It gives platform-specific information which can make an iOS developer more valuable from within their team.

# Conclusion
iOS development can be a challenging and rewarding experience, but it's important to avoid common mistakes that can impact the success of an application.
Memory management, testing on real devices, prioritizing accessibility, ignoring the user interface, and skipping the App Store review guidelines are all common mistakes that developers should strive to avoid.
Investing time and resources into these areas, developers can ensure that their applications are well-designed, functional, and accessible to all users. Following Apple's guidelines and utilizing tools like Instruments, Xcode, and TestFlight can also help developers stay on track and deliver high-quality applications.
By avoiding these common mistakes, developers can build applications that meet the needs of users and contribute to a positive user experience.

