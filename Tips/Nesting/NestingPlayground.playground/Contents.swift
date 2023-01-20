import UIKit

class Solution {
    func maxDistance(_ position: [Int], _ m: Int) -> Int {
        let position = position.sorted()
        let length = position.count
        
        /// number of balls that can fint - with the gap passed
        func ballsWillFit(_ d: Int) -> Int {
            var result = 1
            var cur = position[0]
            for pos in position where (pos - cur) >= d {
                cur = pos
                result += 1
            }
            return result
        }
        
        var left = 0
        var right = position[length - 1] - position[0]
        while left < right {
            let center = right - (right - left) / 2
            if ballsWillFit(center) >= m {
                left = center
            } else {
                right = center - 1
            }
        }
        return left
    }
}

let sol = Solution()

//print (
//    sol.maxDistance([1,2,3,4,7], 3) // 3
//)


class Test {
    var name: String
    init(name: String) {
        print ("init")
        self.name = name
    }
    func testFunc() {
         weak var _self = self
        func test() {
//            print ("test", name)
         print ("test \(_self?.name)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            test()
        }
    }
    
    deinit {
        print ("deinit called")
    }
}

var test: Test? = Test(name: "test")
test?.testFunc()
test = nil
