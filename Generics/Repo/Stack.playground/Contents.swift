import UIKit
import XCTest

class Stack<T> {
    var elements = [T]()
    func pop () -> T? {
        if let last = elements.last {
            elements = elements.dropLast()
            return last
        }
        return nil
    }
    
    func push(_ element: T) {
        elements.append(element)
    }
    

}

extension Stack {
    func peek() -> T? {
        return elements.last
    }
}

// nil case

// push
// push one element - make sure it is there
// Int
// Character
// push multiple element types - error
// push multiple elements of one type, and single element of another type
// push entirely mixed elements

let stackNil = Stack<Character>()
stackNil.elements.count // 0
stackNil.elements // []

let stackIntNil = Stack<Int>()
stackIntNil.elements.count // 0
stackIntNil.elements // []

let stackCharacter = Stack<Character>()
stackCharacter.push("A")
//stackOne.push(1) // returns an error
stackCharacter.elements.count // 1
stackCharacter.elements // "A"

//let stackInt = Stack<Int>() errors
//stackInt.push(1)
//stackInt.push("A")
//stackInt.push(2)
//stackInt.push("B")

//stackOne.pop()


// pop - For each test we need to make sure that the remaining elements are the elements that we expect - test by repeated use of pop until you have nil
// nil case - expect nil
let emptyPopStack = Stack<Int>()
emptyPopStack.pop() // nil
// one element - Int / Character
let intPopStack = Stack<Int>()
intPopStack.elements = [1]
intPopStack.pop() // 1

// Character


// Many elements (2+)
let intManyPopStack = Stack<Int>()
intManyPopStack.elements = [1,2]
intManyPopStack.pop() // 2
intManyPopStack.elements.count // 1
intManyPopStack.elements == [1] // true

// Many many elements (100000+)
let intManyManyPopStack = Stack<Int>()
intManyManyPopStack.elements = [1,2,4,3,5,6,1,5,7]
intManyManyPopStack.pop() // 7
intManyManyPopStack.elements.count // 8
intManyManyPopStack.elements == [5] // true

// Test for type of element that is being returned

// peek
// nil case - expect nil
// elements with one - expect single element to be returned
// elements with 2+ - expect the final element to be returned
// [2,3] - return 3
// ["a","k"] - return "k"


