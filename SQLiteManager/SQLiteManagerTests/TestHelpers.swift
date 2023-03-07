//
//  TestHelpers.swift
//  SQLiteManagerTests
//
//  Created by Steven Curtis on 16/10/2020.
//

import Foundation
import SQLite3
@testable import SQLiteManager

class TestHelpers {
    func testPath() -> String? {
        let testBundle = Bundle(for: type(of: self))
        if let filePath = testBundle.path(forResource: "testDB", ofType: "sqlite") {
            return filePath
        }
        fatalError("Database not found")
    }
    
    func readFromTable(table: String, _ dbpointer: OpaquePointer) -> [[String]] {
        //this is our select query
        let queryString = "SELECT * FROM \(table)"
        //statement pointer
        var stmt:OpaquePointer?
        //preparing the query
        if sqlite3_prepare(dbpointer, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error preparing insert: \(errmsg)")
            return [[]]
        }
        var output: [[String]] = []
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            if let field = sqlite3_column_text(stmt, 1) {
                output.append([ String(id) , String(cString: field) ])
            }
        }
        return output
    }
}


//    func inMemoryDB() -> OpaquePointer?  {
//        var db: OpaquePointer? = nil
//        if sqlite3_open_v2("file::memory:?cache=shared",&db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK{
//            return db
//        } else {
//            return nil
//        }
//    }

//        let db = inMemoryDB()!
        
//        try! mgr.delete(table: "mytable", deleteValues: PairedVals(column: "ID", data: .integer(2)), db, completion: {
//            print ("A")
//        })
