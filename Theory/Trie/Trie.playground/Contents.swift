import UIKit

class TrieNode : CustomStringConvertible {
    var description: String {
        return children.keys.description + children.values.description
    }
    var children = [Character:TrieNode]()
    var isFinal : Bool = false
    func createOrReturn(_ char: Character) -> TrieNode{
        if let child = children[char] {
            return child
        }
        // create a new node
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
        var nodes = getNodesList(word: word)
        if nodes == nil {return false}
        if !nodes!.last!.isFinal {return false}
        for node in nodes!.reversed().enumerated() {
//             print ("node", node.element.children.count)
            print ("node", node)

            if (node.element.children.count == 0) {
//                print ("remove nil one", nodes![node.offset + 1].children.keys)
//                print ("remove nil one", nodes![node.offset + 1].children.filter{ $0.value.children.description != 0 } )
                
//                print ("remove nil one", nodes![node.offset + 1].children.filter{ $0.value.children.count != 0 })
            }
            
//            if (node.element.children.keys.count == 1) {
//                print ("c", node.element.children.first!.key.description)
//            }
////            print (node.element.children.keys.count == 1 && node.element.children.first!.key.description == [])
//            if node.offset + 1 < nodes!.count && nodes![node.offset + 1].children.count == 0  {
////                print ("D", node.element.children )
//
//                if let ky = node.element.children.first?.key {
////                    print ("delete me do", ky)
//                    nodes![node.offset + 1].children.removeValue(forKey: ( ky ) )
//                }
//            }
        }
        return false
    }
}

var myTrie = Trie()
//myTrie.insert("word")
myTrie.insert("a")

print (myTrie)
//myTrie.insert("worst")
//myTrie.insert("hi")
//myTrie.insert("hit")
//print (myTrie.getNodesList(word: "word"))
// print (myTrie.getNodesList(word: "rem")) // nil - not a word
//print (myTrie.getNodesList(word: "worst"))

//myTrie.delete(word: "worst")
//myTrie.contains(word: "worst") // false
//print (myTrie)
//myTrie.contains(word: "word") // true

//myTrie.contains(word: "word") // true
//myTrie.contains(word: "aaa") // false
//myTrie.contains(word: "wo") // false
//myTrie.contains(word: "hi") // hi is there, but is not stored as a word
//myTrie.remove(word: "word")
//myTrie.contains(word: "word") // the word is still there, but we remove the boolean
//print (myTrie.root.children.count)
//print (myTrie)

