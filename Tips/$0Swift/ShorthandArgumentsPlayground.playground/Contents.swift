import UIKit

let names = ["Tom", "Ahmed", "Karen"]
let ascendingNames = names.sorted(by: { $0 < $1 })
print(ascendingNames)

var numbers = [5,3,6,2,6,3]
let sortedNumbers = numbers.sorted { (firstNumber, secondNumber) in
    return firstNumber < secondNumber
}

print(sortedNumbers)

struct Users {
    let data: [Data]
    struct Data {
        let firstName: String
        let secondName: String
        let email: String
    }
}

let loggedInUsers = Users(data: [.init(firstName: "Dave", secondName: "Roberts", email: "dave@loggedin")])
let loggedOutUsers = Users(data: [.init(firstName: "Vishala", secondName: "Logged out", email: "Vishala@loggedout")])

class ViewModel {
    var completion: ((Users) -> Void)?
    var complexCompletion: ((Users, Users) -> Void)?
}

let viewModel = ViewModel()

viewModel.completion = {
    print($0.data.map{ "\($0.firstName) \($0.secondName)" })
}


viewModel.completion!(loggedInUsers)

viewModel.complexCompletion = {
    print( "Logged in: \($0.data.map{ $0 })", "Logged out: \($1)" )
}

viewModel.complexCompletion!(loggedOutUsers, loggedOutUsers)


var dictionary: [Character: (Character, Int)] = ["A": ("a", 1), "B": ("b", 2), "C": ("c", 3)]

dictionary.forEach{
    print($1.1)
}
