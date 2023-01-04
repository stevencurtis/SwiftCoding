import UIKit

var str = "Hello, playgrounds"
print (str)

one(num: 23)

var people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "Peeps.json")
print (people)
