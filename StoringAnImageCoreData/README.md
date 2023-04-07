# Storing Data in Core Data: UIImage
## Proceed with caution

![Photo by C Dustin on Unsplash](Images/photo-1569428034239-f9565e32e224.jpeg)<br/>
<sub>Photo by C Dustin on Unsplash<sub>

Difficulty: Beginner | Easy | **Normal** | Challenging

You probably shouldn't be doing this. You probably shouldn't be doing this.

Core Data can store data, but storing large images like this? Probably you want to use file. But I can see that you **really** want to store `UIImage`. In that case, let us strap in and get going.

# Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift
* You’ll need to know about the [basics of Core Data](https://medium.com/better-programming/core-data-basics-swift-persistent-storage-ba3185fe7061)
* Core Basics [testing](https://medium.com/@stevenpcurtis.sc/core-data-basics-testing-39d127380680)

# Terminology:
Core Data: A framework that allows you to manage the model layer objects in your application. Core Data does this by being an object graph management and persistence framework.

## The image to store
In `Assets.xcassets`  I've added three Placeholder images. 

[placeholder](Images/placeholder.png)

So...surely I can place this image into core data...right?

This involves adding an image attribute to the core data entity, and give it the type `Binary Data`.

[BinaryData](Images/BinaryData.png)

This Binary Data will, fairly obviously, be the data from an image, and for this I can use the useful `pngData()` like:

```swift
let image = UIImage(named: "Placeholder")
let imageData = image?.pngData()
```

## Setting Binary Data
The type for the image is actually Binary Data. 
[BinaryData](Images/BinaryData.png)

## Saving the Data
You need to be mindful about using the existing `managedObjectContext` to perform your changes:
```swift
func save(data: Data, completion: @escaping ( ()-> Void) ) {
    managedObjectContext.perform {
        let imageObject = NSManagedObject(entity: self.entity, insertInto: self.managedObjectContext)
        imageObject.setValue(data, forKey: Constants.imageAttribute)
        
        self.saveContext(completion: {
            completion()
        })
    }
}
```

For more details about this take a look at the attached Repo.

## Improving Performance
I use [DB Browser for SQLite](https://sqlitebrowser.org/dl/) to view data in Core Data. It isn't too tricky to find your Core Data file - it is named after your application in the `Application Support` directory. 

To check (if you're simulating particularly) your files you can whack the following into your `didFinishLaunchingWithOptions` in your `AppDelegate` file.

```swift
print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
```

which will refer you to your documents directory (so move up one folder, and choose your library folder and then the Application Support directory. 

I opened mine in [DB Browser for SQLite](https://sqlitebrowser.org/dl/), and Browse Data:  

[sqldata](Images/sqldata.png)

We can see the image here, which is 10Kib. Fine. But for larger images?

Binary Data can be set to `Allows External Storage`. This is the point where CoreData can decide whether it wants to store data as a file - this takes place depending on the size of the Binary Data - which is very nice of it!

[sqlblob](Images/sqlblob.png)

Which is a reference to the file! In order to see these larger files you must use a shortcut:

⌘ ⇧ . as a shortcut shows hidden files. Within this Application Support folder press this and you can see a `.StoringAnImageCoreData_SUPPORT` folder. Wow!

# Conclusion
You want to store in Core Data? You want an Image to be placed there? It's done! You're worried about performance? It's done. 

All sorted for you!

I hope this article has helped you out, to at least some extent.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
