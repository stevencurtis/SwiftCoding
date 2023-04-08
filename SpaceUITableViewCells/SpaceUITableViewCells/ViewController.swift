//
//  ViewController.swift
//  SpaceUITableViewCells
//
//  Created by Steven Curtis on 24/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // A property to reference a UITableView instance
    var tableView: UITableView!
    
    // The height that will separate the UITableViewCells
    let cellSpacingHeight: CGFloat = 5
    
    // The data, an Array of String. Each Intended to be displayed in a single TableViewCell
    var data: [String] = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey"]

    // Called after ViewController is loaded into memory
    override func viewDidLoad() {
        // Super should always be called, as viewDidLoad() is overridden
        super.viewDidLoad()
        setupTableView()
    }
    
    // Creates the views that the view controller manages
    override func loadView() {
        tableView = UITableView(frame: .zero)
        self.view = tableView
    }
    
    func setupTableView(){
        // register the class of the UITableViewCell, and the identifier for reuse
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        // the delegate will be this class
        tableView.delegate = self
        // the data source will be this class
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // set each section to have one single item. This works without the
        // return keyword where there is a dingle line
        1
    }
    
    // the number of sections in a UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // returns the number of items in the data array, works without the return keyword
        // where there is a single line
        data.count
    }
    
    // which cell should be used for which row? Return it!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if there is an existing cell, reuse it. If not create a new cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell {
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
    
    // the header to display for a particular section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // set up a UIView
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        // choose the colour to be blue
        view.backgroundColor = .blue
        // return the new view
        return view
    }

    // give the height to use for a particular section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
    }
    
}
