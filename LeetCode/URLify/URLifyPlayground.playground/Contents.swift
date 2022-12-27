import UIKit

func replace(input: String) -> String {
    input.replacingOccurrences(of: " ", with: "%20")
}

replace(input: "Mr John Smith") // Mr%20John%20Smith


func replaceWithPercentEncoding(input: String) -> String {
    input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? input
}

replaceWithPercentEncoding(input: "Mr John Smith") // Mr%20John%20Smith

func replaceSpaces(input: String, trueLength: Int) -> String {
    var output = input
    let numberSpaces = trueLength - input.count
    var readPointer = numberSpaces - 1
    while readPointer > -trueLength + numberSpaces - 1 {
        let char = (output[output.index(output.endIndex, offsetBy: readPointer)])
        if char == " " {
            output.replaceSubrange(
                output.index(
                    output.endIndex,
                    offsetBy: readPointer
                )..<output.index(
                    output.endIndex,
                    offsetBy: readPointer + 1
                ),
                with: "%20"
            )
            output.removeLast(2)
            readPointer -= 2
        }
        readPointer -= 1
    }
    return output
}

replaceSpaces(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith

func replaceNewString(input: String, trueLength: Int) -> String {
    var inputArray = Array(input)
    var output = ""
    let numberSpaces = input.count - trueLength
    var readPointer = 0
    while readPointer < trueLength {
        let index = input.index(input.startIndex, offsetBy: readPointer)
        let char = input[index]
        if inputArray[readPointer] == " " {
            output.append("%20")
        } else {
            output.append(char)
        }
        readPointer += 1
    }
    return output
}

replaceNewString(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith


//func replaceInsert(input: String, trueLength: Int) -> String {
//    var output = Array(input)
//    let numberSpaces = input.count - trueLength
//    var readPointer = trueLength - 1
//    var writePointer = input.count - 1
//    while readPointer >= 0 {
//        let readIndex = input.index(input.startIndex, offsetBy: readPointer)
//        let char = (input[readIndex])
//        if char == " " {
//            output[writePointer] = "0"
//            writePointer -= 1
//            output[writePointer] = "2"
//            writePointer -= 1
//            output[writePointer] = "%"
//        } else {
//            output[writePointer] = char
//        }
//        writePointer -= 1
//        readPointer -= 1
//    }
//    return String(output)
//}

func replaceInsert(input: String, trueLength: Int) -> String {
    var output = Array(input)
    let numberSpaces = input.count - trueLength
    var readPointer = trueLength - 1
    var writePointer = input.count - 1
    while readPointer >= 0 {
        let char = output[readPointer]
        if char == " " {
            output[writePointer] = "0"
            writePointer -= 1
            output[writePointer] = "2"
            writePointer -= 1
            output[writePointer] = "%"
        } else {
            output[writePointer] = char
        }
        writePointer -= 1
        readPointer -= 1
    }
    return String(output)
}

replaceInsert(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith
