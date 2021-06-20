//
//  ViewController.swift
//  ReusableUITableViewCellUIImage
//
//  Created by Steven Curtis on 13/06/2021.
//

import UIKit

class ViewController: UIViewController {
    var names: [String] = ["James", "Tom", "Abhay"]
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func loadView() {
        let view = tableView
        self.view = view
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.name = names[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProfileTableViewCell else { fatalError() }
        cell.setup(name: names[indexPath.row])
        return cell
    }
}
