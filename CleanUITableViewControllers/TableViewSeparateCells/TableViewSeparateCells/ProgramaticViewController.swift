//
//  ProgramaticViewController.swift
//  TableViewSeparateCells
//
//  Created by Steven Curtis on 30/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ProgramaticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var myTableView: UITableView!
    var dataArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10 {
            dataArray.append("item " + String(i) )
        }

        //myTableView = UITableView(frame: CGRect(x: 0, y: view.f, width: displayWidth, height: displayHeight - barHeight))
        myTableView = UITableView(frame: view.frame)
//        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil);
        myTableView.register(nib, forCellReuseIdentifier: "MyCell")
        
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(dataArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! MyTableViewCell
//        cell.testLabel!.text = "\(dataArray[indexPath.row])"
        cell.testLabel.text = "test"
        return cell
    }

}
