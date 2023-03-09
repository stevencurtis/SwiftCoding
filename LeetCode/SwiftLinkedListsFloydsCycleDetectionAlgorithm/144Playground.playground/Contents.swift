import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        return self.val.description
    }
}

extension ListNode: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next?.description)
    }
}

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        var nodeArray: [ListNode] = []
        var current = head
        while current != nil {
            if nodeArray.contains(current!) {
                return true
            }
            nodeArray.append(current!)
            current = current?.next
        }
        return false
    }
}
