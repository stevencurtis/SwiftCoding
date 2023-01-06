import UIKit

final class StringBuilder {
    private var value: [Character]
    init(_ string: String = "") {
        value = Array(string)
    }
    
    init(_ capacity: Int) {
        value = []
        value.reserveCapacity(capacity)
    }
    
    func append(_ string: String) {
        value.append(contentsOf: string)
    }
    
    func toString() -> String {
        return String(value)
    }
    
    func capacity() -> Int {
        value.capacity
    }
    
    func ensureCapacity(min: Int) {
        value.reserveCapacity(min)
    }
    
    func insert(_ offset: Int, _ string: String) {
        value.insert(contentsOf: string, at: offset)
    }
    
    func replace(_ start: Int, _ end: Int, _ s: String) {
        value.replaceSubrange(start...end, with: s)
    }
    
    func delete(_ start: Int, _ end: Int) {
        value.removeSubrange(start...end)
    }
    
    func reverse() {
        value = value.reversed()
    }
    
    func charAt(index: Int) -> Character {
        value[index]
    }
    
    func length() -> Int {
        value.count
    }
    
    func substring(start: Int) -> String? {
        guard start<value.endIndex else { return nil }
        return String(value[start..<value.endIndex])
    }
    
    func substring(start: Int, end: Int) -> String? {
        guard start<end else { return nil }
        return String(value[start..<end])
    }
    
    func indexOf(str: String) -> Int? {
        value.firstIndex(of: Character(str)) ?? nil
    }
    
    func lastIndexOf(str: String) -> Int? {
        value.lastIndex(of: Character(str))
    }
    
    func trimToSize() {
        value.reserveCapacity(value.count)
    }
}

// using StringBuilder() constructor
let str = StringBuilder()
str.append("GFG")
print("String = \(str.toString())")

let str1 = StringBuilder("AAAABBBCCCC")
print("String1 = \(str1.toString())")

let str2 = StringBuilder(10)
print("String2 capacity = \(str2.capacity())")

let str3 = StringBuilder(str1.toString())
print("String3 = \(str3.toString())")

str3.insert(1, "zw")
print("String3 inserted = \(str3.toString())")

str3.replace(2, 3, "23")
print("String3 replaced = \(str3.toString())")

str3.delete(2, 3)
print("String3 deleted = \(str3.toString())")

str3.reverse()
print("String3 reversed = \(str3.toString())")

print("String3 at index 2 = \(str3.charAt(index: 2))")

print("String3 final two letters = \(str3.substring(start: 9) ?? "")")

print("String3 final two letters = \(str3.substring(start: 9, end: 11) ?? "")")

print("String3 indexOf = \(str3.indexOf(str: "z") ?? -1)")

print("String3 indexOf = \(str3.lastIndexOf(str: "A") ?? -1)")

//`StringBuilder()`
//`StringBuilder(int capacity)`
//`StringBuilder(CharSequence seq)`
//`StringBuilder(String str)`
//`StringBuilder append (String s)`
//`StringBuilder insert (int offset, String s)`
//`StringBuilder replace(int start, int end, String s)`
//`StringBuilder delete(int start, int end)`
//`StringBuilder reverse()`
//`int capacity()`
//`void ensureCapacity(int min)`
//`char charAt(int index)`
//`int length()`
//`String substring(int start)`
//`String substring(int start, int end)`
//`int indexOf(String str)`
//`int lastIndexOf(String str)`
//`Void trimToSize()`
