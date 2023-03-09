import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let strings = ["1", "2", "3", "4", "5"]
    var tableView : UITableView!
    
    override func loadView() {
        self.tableView = UITableView()
        self.view = tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = strings[indexPath.row]
        return cell!
    }
}

// set the view and indefinite execution
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = MyViewController()

