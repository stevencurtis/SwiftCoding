import Foundation
@testable import TestObservationOldWay

extension Post: Equatable {
    static public func == (lhs: Post, rhs: Post) -> Bool {
        lhs.title == rhs.title
    }
}
