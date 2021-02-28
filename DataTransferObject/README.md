# Using Data Transfer Objects (DTO) in Swift Code
## Copy that stuff

![photo-1601758066681-04e3557afaaa](Images/photo-1601758066681-04e3557afaaa.jpeg)
<sub>Photo by Chewy on Unsplash</sub>

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.1, and Swift 5.3

If you want to pass data around your App, more than likely you will need to use a Data Transfer Object (DTO) to do so

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## Terminology
Data Transfer Object (DTO): An object that carries data between processes

# The simple case
It turns out I've been using Data Transfer Objects (DTO) without even knowing it! The [codable](https://medium.com/@stevenpcurtis.sc/codable-in-swift-and-ios-12a1415b9aa6) protocol gives us a great way accessing API services. 

The example code (which uses my Network Manager) calls `https://jsonplaceholder.typicode.com/todos/1` means that this can look like the following:

```swift
struct ToDo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
```

similarly `NSManagedObject` subclass can be used for [Core Data](https://medium.com/swlh/core-data-using-codable-68660dfb5ce8) implementations.


This means that we might like to create a `toEntity` function to return the entity. An example?

```swift
extension ToDo {
	func toEntity(in context: NSManagedObjectContext) -> ToDoEntity {
		let entity: ToDoEntity = .init(context: context)
		entity,userId = userId	
		entity.id = id
		entity.title = title
		entity.completed = completed
		return enttity
	}
}
```

Some people like to separate out the idea of an entity from a DTO by using a suffix (perhaps a DTO suffix), but this can be an overkill for some projects and implementation / this is an individual choice for the programmer involved.

# Conclusion
We might think of these as `DTO` in order to decouple our network layer from the UI and other modules. Inevitably Martin Fowler has an [article](https://martinfowler.com/eaaCatalog/dataTransferObject.html) on this if you want to read into this topic in more detail.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
