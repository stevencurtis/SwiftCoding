import UIKit
import XCTest

class TrieNode : CustomStringConvertible {
    var description: String {
        return children.keys.description + children.values.description
    }
    var children = [Character:TrieNode]()
    var isFinal : Bool = false
    func createOrReturn(_ char: Character) -> TrieNode {
        if let child = children[char] {
            // if it exists, return the existing node
            return child
        }
        // create a new node and return it
        let newNode = TrieNode()
        children[char] = newNode
        return newNode
    }
}

class Trie : CustomStringConvertible {
    var description: String {return root.description }
    var root = TrieNode()

    // contains O(n)
    func insert(_ inp: String) {
        var node = root
        for char in inp {
            node = node.createOrReturn(char)
        }
        node.isFinal = true
    }
    
    // contains O(n)
    func contains (word: String) -> Bool {
        var node = root
        for char in word {
            if node.children[char] == nil {
                return false
            }
            node = node.children[char]!

        }
        return node.isFinal
    }
    
    // removing just changes the isFinal boolean. It does not actually remove the elements
    // from the trie
    func remove (word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                return
            }
            node = node.children[char]!
        }
        node.isFinal = false
    }
    
    func getNodesList(word: String) -> [TrieNode]? {
        var nodes : [TrieNode] = [root]
        var node = root
        for char in word {
            if node.children[char] == nil {
                return nil
            }
            node = node.children[char]!
            nodes.append(node)
        }
        return nodes
    }
    
    // return a path for a given node. Returns true if done, false if failed.
    func delete(word: String) -> Bool {
        var deleteWord = Array(word)
        var nodes = getNodesList(word: word)
        guard nodes != nil else {return false}

        var wordIndex = deleteWord.count - 1

        // the first element is a blank child
        for nodeIdx in (1..<nodes!.count - 1 ).reversed() {
            // Is the node is a leaf node, wipe it (for the current letter of the word)

            if ( nodes![nodeIdx].children[ deleteWord[wordIndex] ]!.children.count < 1 ) {
                 nodes![nodeIdx].children[ deleteWord[wordIndex] ] = nil
            }
            wordIndex -= 1
        }
        return true
    }
}

var myTrie = Trie()
myTrie.insert("word")
print (myTrie)
myTrie.insert("worst")
print (myTrie)
print (myTrie.root.children.keys.first!) // w
print (myTrie.root.children.values.first!.children.keys.first!) // o
print (myTrie.root.children.values.first!.children.values.first!.children.keys.first!) // r
print (myTrie.root.children.values.first!.children.values.first!.children.keys.count) // 1
myTrie.insert("hit")
print ("all three", myTrie.root.children.keys)


// r branches, and has two
print (myTrie.root.children.values.first!.children.values.first!.children.values) // d and s are the values

print (myTrie.root.children.values.first!.children.values.first!.children.values.count) // d and s are the values
// BUT the values are themselves a dictionary, so the chilren of r is a

////myTrie.insert("a")
////print (myTrie)
//myTrie.insert("worst")
////myTrie.insert("hi")
////myTrie.insert("hit")
////print (myTrie.getNodesList(word: "word"))
//// print (myTrie.getNodesList(word: "rem")) // nil - not a word
////print (myTrie.getNodesList(word: "worst"))
//
//myTrie.contains(word: "word") // true
//myTrie.contains(word: "worst") // true
//
//myTrie.delete(word: "word")
//myTrie.contains(word: "word") // false
//myTrie.contains(word: "worst") // true
//
//print (myTrie)
////myTrie.contains(word: "word") // true
//
////myTrie.contains(word: "word") // true
////myTrie.contains(word: "aaa") // false
////myTrie.contains(word: "wo") // false
//myTrie.insert("hi")
//myTrie.insert("hit")
//
//myTrie.contains(word: "hi") // hi is there, but is not stored as a word
//myTrie.remove(word: "word")
//myTrie.contains(word: "worst") // true
//myTrie.contains(word: "hi") // true
//myTrie.remove(word: "hi")
//myTrie.contains(word: "hit") // true
//
//myTrie.contains(word: "hi") // false
//
////myTrie.contains(word: "word") // the word is still there, but we remove the boolean
////print (myTrie.root.children.count)
//print (myTrie)


class TrieTests: XCTestCase {

    /// Tests the insert method
    func testInsert() {
        let trie = Trie()
        trie.insert( "cute")
        trie.insert( "cutie")
        trie.insert( "fred")
        XCTAssertTrue(trie.contains(word: "cute"))
        XCTAssertFalse(trie.contains(word: "cut"))
        trie.insert( "cut")
        XCTAssertTrue(trie.contains( word: "cut"))
    }
    
    /// Tests the remove method
    func testRemove() {
        let trie = Trie()
        trie.insert("cute")
        trie.insert("cut")
        trie.remove(word: "cute")
        XCTAssertTrue(trie.contains(word: "cut"))
        XCTAssertFalse(trie.contains(word: "cute"))
    }
}

//TrieTests.defaultTestSuite.run()
