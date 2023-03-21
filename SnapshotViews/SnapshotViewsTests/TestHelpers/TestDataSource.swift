//
//  TestDataSource.swift
//  SnapshotViewsTests
//
//  Created by Steven Curtis on 23/10/2020.
//

import Foundation
import UIKit
@testable import SnapshotViews
import FBSnapshotTestCase


class TestDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell {
            
            cell.textLab?.numberOfLines = 0
            cell.textLab?.text = "aaaa"
            return cell
        }
        fatalError("Could not dequeue CustomCell")
    }
}
