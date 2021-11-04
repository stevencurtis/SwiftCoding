//
//  ViewController.swift
//  MultipleInitializers
//
//  Created by Steven Curtis on 02/11/2021.
//

import UIKit

class ViewController: UIViewController {

    // Outlet    
    @IBOutlet private var tableView: UITableView!
    // Private
    let viewModel: ViewModel
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        let cellNib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }

    // - Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentTableViewCell
        
        cell.configure(with: .title("text"))
//        cell.configure(with: .image(.name("CircularProfile")))
        
        return cell
    }
}
