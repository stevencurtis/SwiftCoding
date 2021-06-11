//
//  ViewController.swift
//  ProgrammaticUITableViewCell
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // A property to reference a UITableView instance
    var tableView: UITableView!
    // The data, an Array of String. Each Intended to be displayed in a single TableViewCell
    var data: [String] = ["a", "b", "c", "d", "e", "f"]

    // Called after ViewController is loaded into memory
    override func viewDidLoad() {
        // Super should always be called, as viewDidLoad() is overridden
        super.viewDidLoad()
        setupTableView()
    }
    
    // A String to identify a cell, and enable cells that scroll outside of the view to be reused
     let cellReuseIdentifier = "cell"
    
    // Creates the views that the view controller manages
    override func loadView() {
        tableView = UITableView(frame: .zero)
        self.view = tableView
    }
    
    func setupTableView(){
        // register the class of the UITableViewCell, and the identifier for reuse
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // the delegate will be this class
        tableView.delegate = self
        // the data source will be this class
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of items in the data array, works without the return keyword
        // where there is a single line
        data.count
    }
    
    // which cell should be used for which row? Return it!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if there is an existing cell, reuse it. If not create a new cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CustomTableViewCell {
            // which row are we working on?
            let currentRow = indexPath.row
            // set the text from the data array
            cell.textLabel?.text = data[currentRow]
            // return the completed cell
            cell.setupCell(image: "PlaceholderImage")
            return cell
        }
        // if no cell can be reused or created, something is seriously wrong so crash
        // the device (this should therefore not happen)
        fatalError("could not dequeueReusableCell")
    }
}

