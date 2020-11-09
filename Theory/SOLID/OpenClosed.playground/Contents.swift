import UIKit

protocol DataProtocol{
    func getData() -> Data?
}

final class NetworkData {
    func getData() -> Data? {
        // fetch data with URLSession
        return nil
    }
}

final class PersistentData {
    func getData() -> Data? {
        // fetch data from CoreData, or similar
        return nil
    }
}

let getURLData = NetworkData()
let returnedData = getURLData.getData()

// to add SQL getData we don't need to change anything else, and can add the class below

final class SQLData {
    func getData() -> Data? {
        // fetch data from Database
        return nil
    }
}
