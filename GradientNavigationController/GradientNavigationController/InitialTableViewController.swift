//
//  InitialTableViewController.swift
//  GradientNavigationController
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit


class InitialTableViewController: UITableViewController {
    
    let data = ["a", "b", "c"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = .blue
        
        
        let gradientLayer = CAGradientLayer()
           var updatedFrame = self.navigationController!.navigationBar.bounds
           updatedFrame.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
           gradientLayer.frame = updatedFrame
           gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
           gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
           UIGraphicsBeginImageContext(gradientLayer.bounds.size)
           gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           self.navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)

           let appearance = navigationController!.navigationBar.standardAppearance.copy()
           appearance.backgroundImage = image
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance  
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        performSegue(withIdentifier: "detail", sender: indexPath.row)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let dest = segue.destination as? DetailViewController {
                dest.data = data[sender as! Int]
            }
        }
    }
}
