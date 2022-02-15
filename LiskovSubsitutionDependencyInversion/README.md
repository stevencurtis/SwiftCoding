# What Is The Difference Between The Liskov Substitution Principle and Dependency Inversion Principle?
## Often Confused, Never Replaced

The SOLID Principles consist of five principles for Object Oriented Design, written by Robert Cecil Martin.

I've found that two of the principles, the *Liskov Substitution Principle* and *Dependency Inversion Principle* both cover similar ground and can be confused. 

This article is designed to disambiguate the two, and make it clear what those two principles are for and how they might help you as a software engineer.

## The Liskov Substitution Principle
Functions that use pointers or references to base classes must be able to use objects of the derived classes without they are using a derived class. 
In plain English, objects in a superclass should be replaceable with objects of it's subclass.
The principle:

```Objects of a superclass shall be replaceable with objects of its subclasses without breaking the application```

If we think about this as programmers, we commonly write child classes that inherit from a parent class. A classic textbook example might be that a `Car` inherits certain behaviours from a `Vehicle` class.

!(Images/Liskov/GasCapacity/GasCapacity.png)[Images/Liskov/GasCapacity/GasCapacity.png]

So the Type (`Vehicle`) in code should be able to be replaced by either of it's subtypes (`Car`, or `Van`). 
Great! This is such an easy example!

However, we need to get into the heart of the problem here. The Liskov Substitution Principle is about how something that seems to work in principle, sometimes does not work elegantly in code. In this case, we've used an abstraction that assumes the subclasses (`Car` and `Van` in this case) both have the property `gasCapacity`. The abstraction can be visibly broken when we add a subclass `ElectricCar` into the mix.

!(Images/Liskov/ElectricCar/ElectricCarCentered.png)[Images/Liskov/ElectricCar/ElectricCarCentered.png]

Here we are expecting the `ElectricCar` to have a `gasCapacity`. Which they don't. Yet it's a `Vehicle`.

This is an example of violating the Liskov Substitution Principle. It is out of the scope of this article to *solve* this issue, as there are many potential solutions here but suffice to say either/or a `Vehicle` shouldn't have a gas property and perhaps we are using the wrong interface for this problem.

## The Dependency Inversion Principle
A high-level `class A` is dependent on a specific instance of `class B`

!(Images/DependencyInversion/1.png)[Images/DependencyInversion/1.png]

This is known as tight coupling, as the classes are highly dependent on one another. Since `Client Class A` is directly dependent on our `Service Class B` when we modify Service Class B we also either need to `Service Class A` which may affect testing and performance (as well as any other dependent classes). The stability and architecture of our entire program is influenced these dependencies.

!(Images/DependencyInversion/2.png)[Images/DependencyInversion/2.png]

```The principle:
High-level modules should not depend on low-level modules. Both should depend on abstractions.
Abstractions should not depend on details. Details should depend on abstractions.```

The principle states that high-level modules (our `Client Class A` in this example) should not be dependent on the low-level class (`Service Class B`).
We can decouple high and low-level classes by using shared abstractions, and in some languages we can call this interface a protocol (as in the diagram below):

!(Images/DependencyInversion/3.png)[Images/DependencyInversion/3.png]

The Principle encourages the re-usability of the higher-level classes and it is common to use the (adaptor pattern)[https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fthe-adapter-design-pattern-in-swift-21fbfe79be17] to mediate between layers of code. Dependency Injection is not the only way to accomplish dependency inversion, but it is a common solution.

## The Confusion
I've often found it tricky to see the difference between the two principles because solutions commonly use an interface.

## The Opportunity
The problem we are trying to solve with these two principles are different.

One is concerned with inheritance and one is concerned with coupling. The solutions may be similar, but the important part is the question that is being solved.

# Conclusion
I hope this article has helped to clear up these rather easily confused ideas, and perhaps even helped you out a little!

I have previously written an article using the language Swift to explain the [SOLID principles where applied to Swift](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fthe-solid-principle-applied-to-swift-974e29b94d23), and a [practical guide to using dependency Injection in Swift](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Flearning-dependency-injection-using-swift-c94183742187) so these might be of help for readers who would like to have more concrete examples of the principles, or if you're working with Swift.

I'd love to hear from you if you have questions.

Subscribing to Medium using this link shares some revenue with me.
