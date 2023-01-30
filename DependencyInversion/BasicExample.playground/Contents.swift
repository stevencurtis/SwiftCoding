import UIKit


//class Database {
//    func create(_ name: String) {}
//    func insert(_ user: User) {}
//    func update(_ user: User) {}
//    func delete(_userID: String) {}
//    required init() {}
//}
//
//struct User: Decodable {
//    let name: String
//    let id: String
//}
//
//
//class UserTransaction {
//    private let dataBase: Database
//
//    init(dataBase: Database) {
//        self.dataBase = dataBase
//    }
//
//    func add(user: User) {
//        dataBase.insert(user)
//    }
//
//    func edit(user: User) {
//        dataBase.update(user)
//    }
//
//    func delete(id: String) {
//        dataBase.delete(_userID: id)
//    }
//}



class Database: DatabaseManager {
    func create(_ name: String) {}
    func insert(_ user: User) {}
    func update(_ user: User) {}
    func delete(_userID: String) {}
    required init() {}
}

protocol DatabaseManager {
    func create(_ name: String)
    func insert(_ user: User)
    func update(_ user: User)
    func delete(_userID: String)
    init()
}

struct User: Decodable {
    let name: String
    let id: String
}


class UserTransaction {
    private let dataBase: DatabaseManager
    
    init(dataBase: DatabaseManager) {
        self.dataBase = dataBase
    }
    
    func add(user: User) {
        dataBase.insert(user)
    }
    
    func edit(user: User) {
        dataBase.update(user)
    }
    
    func delete(id: String) {
        dataBase.delete(_userID: id)
    }
}

let db = Database()
let userTransaction = UserTransaction(dataBase: db)


class MockDatabase: DatabaseManager {
    func create(_ name: String) {}
    func insert(_ user: User) {}
    func update(_ user: User) {}
    func delete(_userID: String) {}
    required init() {}
}
