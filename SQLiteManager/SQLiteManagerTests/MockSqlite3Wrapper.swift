//
//  MockSqlite3Wrapper.swift
//  SQLiteManagerTests
//
//  Created by Steven Curtis on 21/10/2020.
//

@testable import SQLiteManager
import SQLite3

class MockSqlite3Wrapper: Sqlite3WrapperProtocol {
    
    var columns = 0
    
    var outputStrings: [[String]] = [["1", "Hello", "World"], ["2", "a", "b"], ["3", "c", "d"]]
    
    func sqlite3_column_text(_ op: OpaquePointer!, _ iCol: Int32) -> UnsafePointer<UInt8>! {
        if columns < 3 {
            let outputString = outputStrings[counter][columns]
            let data = outputString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let dataMutablePointer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
            data.copyBytes(to: dataMutablePointer, count: data.count)
            let dataPointer = UnsafePointer<UInt8>(dataMutablePointer)
            columns += 1
            return dataPointer
        }
        columns = 0
        return nil
    }
    
    struct MockSqliteRun {
        var close: Bool = false
        var finalize: Bool = false
        var step: Bool = false
        var open: Bool = false
        var prepare: Bool = false
        var column: Bool = false
        var bindInt: Bool = false
        var bindText: [String] = []
    }
    
    var whichRun: MockSqliteRun = MockSqliteRun()
    func sqlite3_close(_ pointer: OpaquePointer!) -> Int32 {
        whichRun.close = true
        return 0
    }
    
    func sqlite3_finalize(_ pStmt: OpaquePointer!) -> Int32 {
        whichRun.finalize = true
        return 0
    }
    
    var counter = -1
    var stepdone = false
    
    func sqlite3_step(_ pointer: OpaquePointer!) -> Int32 {
        whichRun.step = true
        if (stepdone) {return SQLITE_DONE}
        if counter < 1 {
            counter += 1
            return SQLITE_ROW
        }
        return SQLITE_DONE
    }
    
    func sqlite3_open_v2(_ filename: UnsafePointer<Int8>!, _ ppDb: UnsafeMutablePointer<OpaquePointer?>!, _ flags: Int32, _ zVfs: UnsafePointer<Int8>!) -> Int32 {
        // in order to pass out the reference to the db
        SQLite3.sqlite3_open_v2(filename, ppDb, flags, zVfs)
        whichRun.open = true
        return 0
    }
    
    func sqlite3_prepare_v2(_ db: OpaquePointer!, _ zSql: UnsafePointer<Int8>!, _ nByte: Int32, _ ppStmt: UnsafeMutablePointer<OpaquePointer?>!, _ pzTail: UnsafeMutablePointer<UnsafePointer<Int8>?>!) -> Int32 {
        whichRun.prepare = true
        SQLite3.sqlite3_prepare_v2(db, zSql, nByte, ppStmt, pzTail)
        return SQLITE_OK
    }
    
    func sqlite3_column_int(_ oP: OpaquePointer!, _ iCol: Int32) -> Int32 {
        whichRun.column = true
        return 0
    }
    
    func sqlite3_bind_int(_ oP: OpaquePointer!, _ first: Int32, _ second: Int32) -> Int32 {
        whichRun.bindInt = true
        return SQLITE_OK
    }
    
    func sqlite3_bind_text(_ oP: OpaquePointer!, _ first: Int32, _ second: UnsafePointer<Int8>!, _ third: Int32, _ ptrs: (@convention(c) (UnsafeMutableRawPointer?) -> Void)!) -> Int32 {
        whichRun.bindText.append( String(cString: second) )
        return SQLITE_OK
    }
    
    
}
