//
//  ViewController.swift
//  TableViewProject
//
//  Created by Steven Curtis on 24/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // The data, an Array of String. Each Intended to be displayed in a single TableViewCell
    let people = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey"]
    
    // The hollow circle on the left will become solid when joined to the Storyboard
    @IBOutlet var tableView: UITableView!

    // A String to identify a cell, and enable cells that scroll outside of the view to be reused
     let cellReuseIdentifier = "cell"
    
    // Called after ViewController is loaded into memory
    override func viewDidLoad() {
        // Super should always be called, as viewDidLoad() is overridden
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
        // register the class of the UITableViewCell, and the identifier for reuse
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // the delegate will be this class
        tableView.delegate = self
        // the data source will be this class
        tableView.dataSource = self
    }
}

// Use an extension for the ViewController to conform to the UITableViewDelegate
// and UITableViewDataSource, keeping this code separate from the rest of the
// UIViewController instance
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // the number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of items in the people array, works without the return keyword
        // where there is a single line
        people.count
    }
    
    // which cell should be used for which row? Return it!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if there is an existing cell, reuse it. If not create a new cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) {
            // which row are we working on?
            let currentRow = indexPath.row
            // set the text from the data array
            cell.textLabel?.text = people[currentRow]
            // return the completed cell
            return cell
        }
        // if no cell can be reused or created, something is seriously wrong so crash
        // the device (this should therefore not happen)
        fatalError("Could not dequeue cell")
    }
}
