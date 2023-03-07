//
//  ViewController.swift
//  SQLiteManager
//
//  Created by Steven Curtis on 15/10/2020.
//

import UIKit

public struct PairedVals {
    var column: NSString
    var data: DataTypes
}

enum DataTypes {
    case text(NSString)
    case integer(Int32)
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var data: [String] = []
    
    func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private var createStatement: String {
        return """
      CREATE TABLE Contact(
        Id INT PRIMARY KEY NOT NULL,
        Name CHAR(255)
      );
      """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        let manager: SQLiteManager = SQLiteManager(Constants.db)
        
                manager.open(withCompletionHandler: { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let dbPointer):
//                        try! manager.createTable(createStatement: self!.createStatement)
                        print ( try! manager.listTables() )
//                        let dta = manager.readDB(from: "Pages", dbPointer!)
//                        self?.data = (dta.compactMap{ $0[1] } )
//                        self?.tableView.reloadData()
                    }
                })
    }


}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
}
