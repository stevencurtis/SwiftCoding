//
//  main.swift
//  SubscriptInSwift
//
//  Created by Steven Curtis on 27/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation


var array = [1,2,3,4,5]
print (array[0]) // 1

var matrix = [[0,1],[2,3]]
print (matrix[0][0]) // 0
print (matrix[0][1]) // 1
print (matrix[1][0]) // 2
print (matrix[1][1]) // 3


// Enum to output days unclear syntax
enum EnumDays : Int
{
    case MONDAY = 0
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
}

var weekDay = EnumDays.init(rawValue: 0)
print("Day = \(String(describing: weekDay!))")

// an enum days of the week that allows localisation

enum DaysOfWeek : Int
{
    case MONDAY = 0
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
    
    var asString : String
    {
        var resource = ""
        switch self
        {
        case .MONDAY: resource =  "Monday"
        case .TUESDAY : resource =  "Tuesday"
        case .WEDNESDAY:  resource =  "Wednesday"
        case .THURSDAY: resource = "Thursday"
        case .FRIDAY: resource = "Friday"
        case .SATURDAY: resource = "Saturday"
        case .SUNDAY: resource = "Sunday"
        }
        
        // Use Internationalization, as appropriate.
        return NSLocalizedString(resource, comment: resource)
    }
}
var weekDays = DaysOfWeek.init(rawValue: 0)
print("Day = \(String(describing: weekDays!))")

// subscript with case statements
class Days
{
    subscript(index: Int) -> String
    {
        switch index {
        case 0: return "Monday"
        case 1: return "Tuesday"
        case 2: return "Wednesday"
        case 3: return "Thursday"
        case 4: return "Friday"
        case 5: return "Saturday"
        case 6: return "Sunday"
        default: return "Not a valid day"
        }
    }
}
let days = Days()
print (days[0]) // Monday
print (days[6]) // Sunday
print (days[7]) // Not a valid day


// subscript with array backing
class Daysofaweek {
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    subscript(index: Int) -> String {
        get {
            return days[index]
        }
        set(newValue) {
            self.days[index] = newValue
        }
    }
}
var p = Daysofaweek()
print(p[0]) // prints sunday
p[0] = "Monday"
print(p[0]) // prints Monday

enum ChessColor: String {
    case white = "White"
    case black = "Black"
}

enum ChessboardPiece : String {
    case Pawn
    case Knight
    case Bishop
    case Rook
    case Queen
    case King
}

struct Piece: CustomStringConvertible {
    var colour: ChessColor
    var type: ChessboardPiece
    var description: String {
        return colour.rawValue + " " + type.rawValue
    }
}

struct Chessboard{
    var board: [[Piece?]] = [
        [Piece(colour: .white, type: .Rook), Piece(colour: .white, type: .Knight), Piece(colour: .white, type: .Bishop), Piece(colour: .white, type: .Queen), Piece(colour: .white, type: .King), Piece(colour: .white, type: .Knight), Piece(colour: .white, type: .Rook)],
        [],
        [],
        [],
        [],
        [],
        [],
        [Piece(colour: .black, type: .Rook), Piece(colour: .black, type: .Knight), Piece(colour: .black, type: .Bishop), Piece(colour: .black, type: .Queen), Piece(colour: .black, type: .King), Piece(colour: .black, type: .Knight), Piece(colour: .black, type: .Rook)]
    ]
    let columns : [String:Int] = ["a":0,"b":1,"c":2,"d":3,"e":4,"f":5,"g":6,"h":7]

    subscript(column: Character, row: Int) -> Piece? {
        get {
            if let column = columns[column.description] {
                return board[row - 1][column]
            }
            return nil
        }
    }
}

var myChess = Chessboard()
print (
    myChess["d",1] ?? "Not found" // White Queen
)
print (
    myChess["e",8] ?? "Not found"  // Black King
)

