//import Foundation
//let fileManager = FileManager.default
//let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
//let data = "secret data".data(using: .utf8)
//try? data?.write(to: filePath, options: [.atomic, .completeFileProtection])

//import Foundation
//let fileManager = FileManager.default
//let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
//let data = "secret data".data(using: .utf8)
//try? data?.write(to: filePath, options: [.atomic, .completeFileProtectionUnlessOpen])

//import Foundation
//let fileManager = FileManager.default
//let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
//let data = "secret data".data(using: .utf8)
//try? data?.write(to: filePath, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])

import Foundation
let fileManager = FileManager.default
let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("sensitive.txt")
let data = "secret data".data(using: .utf8)
try? data?.write(to: filePath, options: [.atomic, .noFileProtection])
