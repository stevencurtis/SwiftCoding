//
//  SnapshotViewsTests.swift
//  SnapshotViewsTests
//
//  Created by Steven Curtis on 22/10/2020.
//

import XCTest
@testable import SnapshotViews
import FBSnapshotTestCase


class SnapshotViewsTests: FBSnapshotTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMenu() {
        // For first run
        // recordMode = true
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "menu") as! MenuViewController
        FBSnapshotVerifyView(vc.view)
    }
    
    func testSimpleView() {
        // For first run
        // recordMode = true
        let view = SimpleView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        view.backgroundColor = .green
        FBSnapshotVerifyView(view)
    }

    let ds = TestDataSource()
    
    // however this contains the whole tableview
    func testCell() {
        // For first run
        recordMode = true
        let vc = ViewController(nibName: nil, bundle: nil)
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 375, height: 22), style: .plain)
        vc.tableView = tv
        tv.dataSource = ds
        vc.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomCell")
        FBSnapshotVerifyView(vc.tableView)
    }

    func testOnlyShortCell() {
        recordMode = true
        let cont = TableViewTestView(testText: "Short Text", height: 22)
        FBSnapshotVerifyView(cont)
    }
    
    func testOnlyLongCell() {
        recordMode = true
        let cont = TableViewTestView(testText: "There is a great deal of text in this particular cell, it will take up a great deal of space and perhaps go onto four lines", height: 60)
        FBSnapshotVerifyView(cont)
    }
    
    func testOnlyShortGeneralCell() {
        recordMode = true
        let cont = TableViewTestViewGeneralised<CustomTableViewCell>(height: 22, configureCell: { cell in
            cell.textLab.numberOfLines = 0
            cell.textLab.text = "Short Text"
        })
        FBSnapshotVerifyView(cont)
    }
    
    func testOnlyLongGeneralCell() {
         recordMode = true
        let cont = TableViewTestViewGeneralised<CustomTableViewCell>(height: 60, configureCell: { cell in
            cell.textLab.numberOfLines = 0
            cell.textLab.text = "There is a great deal of text in this particular cell, it will take up a great deal of space and perhaps go onto four lines"
        })
        FBSnapshotVerifyView(cont)
    }
}
