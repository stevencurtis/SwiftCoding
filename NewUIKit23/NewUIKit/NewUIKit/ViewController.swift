//
//  ViewController.swift
//  NewUIKit
//
//  Created by Steven Curtis on 07/06/2023.
//

import UIKit

final class ViewController: UITableViewController {
    
    private var cells: [Cell] = [
        Cell(
            title: "Show Lifecycle",
            segueIdentifier: "showLifecycle"
        ),
        Cell(title: "Set up UIContentUnavailableConfiguration", segueIdentifier: "contentUnavailable"),
        Cell(title: "Set up UIContentUnavailableConfigurationWithSwiftUI", segueIdentifier: "contentUnavailableWithSwiftUI"),
        Cell(title: "UIContentUnavailableConfiguration searchViewController", segueIdentifier: "searchViewController"),
        Cell(title: "Show Animation", segueIdentifier: "showAnimation")
    ]
    
    struct Cell {
        let title: String
        let segueIdentifier: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cells[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: cells[indexPath.row].segueIdentifier,
            sender: nil
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
}


#Preview("ViewController") {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let customViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
    return customViewController
}
