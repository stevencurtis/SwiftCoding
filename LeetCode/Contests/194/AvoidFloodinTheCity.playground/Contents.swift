import UIKit

class Solution {
    func avoidFlood(_ rains: [Int]) -> [Int] {
        // init the output array with -1
        var output: [Int] = Array(repeating: -1, count: rains.count)
        var lakes: [Int:Int] = [:] // represent each lake and the day it is full lake:day
        var dryDays: Array<Int> = [] // array of avaliable drying days
        // for each day
        for i in 0..<rains.count {
            let lake = rains[i]
            // if rains[i] == 0 we have a new dryDay
            if lake == 0 {
                dryDays.append(i)
                output[i] = 1
            } else {
                // we have a new full lake, with fullLakeIndex
                if let fullLakeIndex = lakes[lake] {
                    // minDay is the earliest possible day we can empty the lake
                    var minDay: Int?
                    for day in dryDays.enumerated() {
                        // the dryDay we use to empty the lake MUST be before the current date, and we use the array of drying days to pick the earliest possible
                        if day.element >= fullLakeIndex {
                            minDay = day.element
                            output[minDay!] = lake
                            dryDays.remove(at: day.offset)
                            break
                        }
                    }
                    // if no drying day is avaliable, a flood is inevitable
                    if minDay == nil {
                        return []
                    }
                }
            }
            // Record the day that the lake is filled
            lakes[lake] = i
        }
        return output
    }
}
