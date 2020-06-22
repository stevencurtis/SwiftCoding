import UIKit

class Solution {
    func getFolderNames(_ names: [String]) -> [String] {
        var output: [String] = []
        var hash: [String: Int] = [:]
        for i in 0..<names.count {
            let name = names[i]
            if let num = hash[name] {
                var candidateNumber = num + 1
                var candidateExtension = "(\(candidateNumber))"
                while let _ = hash[name + candidateExtension] {
                    candidateNumber += 1
                    candidateExtension = "(\(candidateNumber))"
                }
                output.append(name + candidateExtension)
                hash[name] = candidateNumber
                hash[name + candidateExtension] = 0

            } else {
                output.append(names[i])
                hash[names[i]] = 0
            }
        }
        return output
    }
}
