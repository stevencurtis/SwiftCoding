//
//  ViewController.swift
//  WhyUseLayoutSubviews
//
//  Created by Steven Curtis on 28/11/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultcell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    let data = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // uncomment the following to see the defaultcell method
//        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
//        cell.textLabel?.text = "Cell data: \(data[indexPath.row])"
  
        // prevent the warning on the visual debugger
//        if let rect = cell.imageView?.bounds {
//            cell.imageView?.layer.shadowPath = UIBezierPath(rect: rect).cgPath
//        }
        
//        cell.imageView?.layer.shadowRadius = 8
//        cell.imageView?.layer.shadowOffset = CGSize(width: 3, height: 3)
//        cell.imageView?.layer.shadowOpacity = 0.5
//        cell.imageView?.layer.cornerRadius = 20
//        cell.imageView?.image = UIImage(named: "PlaceholderImage")
//        return cell
            
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell {
            cell.setupCell(data: data[indexPath.row], image: "PlaceholderImage" )
            return cell
        }
        fatalError()
    }
}
