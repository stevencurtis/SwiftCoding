import UIKit

var str = "Hello, playground"

logHello()

var people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "Peeps.json")
print (people)
