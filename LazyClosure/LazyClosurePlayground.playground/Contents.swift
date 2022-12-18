import UIKit

final class FileReader {
    func readFile() -> String? {
        do {
            guard let fileUrl = Bundle.main.url(
                forResource: "fav",
                withExtension: "json"
            ) else {
                fatalError()
            }
            let text = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            return text
        } catch {
            return nil
        }
    }
    
    lazy var fileContents: String? = {
        do {
            guard let fileUrl = Bundle.main.url(
                forResource: "fav",
                withExtension: "json"
            ) else {
                fatalError()
            }
            let text = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            return text
        } catch {
            return nil
        }
    }()
}

let reader = FileReader()
//print(reader.readFile())


print(reader.fileContents)
print(reader.fileContents)
