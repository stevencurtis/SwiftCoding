//
//  ViewController.swift
//  CountDownTable
//
//  Created by Steven Curtis on 03/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hoursView: CountDown!
    @IBOutlet weak var minutesView: CountDown!
    @IBOutlet weak var secondsView: CountDown!
    @IBOutlet weak var chooseStack: UIStackView!
    @IBOutlet weak var stackContainer: UIView!
    
    var times: [(hours: Int, minutes: Int, seconds: Int)] = []
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    var pickerView: UIView!
    var picker: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func chooseTimeAction(_ sender: UIButton) {
        appearPickerView()
    }
    
    func appearCurrentChoice() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseStack.frame = CGRect(
                x: 0,
                y: (self.navigationController?.navigationBar.frame.height ?? 0)
                + self.chooseStack.bounds.size.height,
                width: self.chooseStack.bounds.size.width,
                height: self.chooseStack.bounds.size.height
            )
            self.stackContainer.alpha = 1
        })
    }
    
    func disappearCurrentChoice() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseStack.frame = CGRect(
                x: 0,
                y: ((self.navigationController?.navigationBar.frame.height ?? 0)
                - self.chooseStack.bounds.size.height),
                width: self.chooseStack.bounds.size.width,
                height: self.chooseStack.bounds.size.height
            )
            self.stackContainer.alpha = 0
        })
    }
    
    func appearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height - self.pickerView.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
            self.tableView.alpha = 0.1
        })
    }
    
    func disappearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
            self.tableView.alpha = 1.0
        })
        
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.selectRow(0, inComponent: 1, animated: false)
        picker.selectRow(0, inComponent: 2, animated: false)
    }
    
    @objc func action() {
        disappearPickerView()
        
        // update the sample view
        hoursView.update(time: .hours, units: CGFloat(0))
        minutesView.update(time: .minutes, units: CGFloat(0))
        secondsView.update(time: .seconds, units: CGFloat(0))
        disappearCurrentChoice()
        
        times.append((hour,minutes,seconds))
        tableView.reloadData()
        
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIView(frame: CGRect(x: 0, y: view.frame.height + 260, width: view.frame.width, height: 260))
        
        self.view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 260),
            pickerView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        pickerView.backgroundColor = .white
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
        pickerView.addSubview(picker)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        picker.isUserInteractionEnabled = true
        pickerView.addSubview(toolBar)
        
        picker.delegate = self
        picker.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let cellNib = UINib(nibName: "TimerTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func addTapped() {
        appearPickerView()
        appearCurrentChoice()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1, 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
            hoursView.update(time: .hours, units: CGFloat(hour), animate: false)
        case 1:
            minutes = row
            minutesView.update(time: .minutes, units: CGFloat(minutes), animate: false)
        case 2:
            seconds = row
            secondsView.update(time: .seconds, units: CGFloat(seconds), animate: false)
        default:
            break
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TimerTableViewCell {
            cell.hoursView.update(time: .hours, units: CGFloat(times[indexPath.row].hours), animate: true)
            cell.minutesView.update(time: .minutes, units: CGFloat(times[indexPath.row].minutes), animate: true)
            cell.secondsView.update(time: .seconds, units: CGFloat(times[indexPath.row].seconds), animate: true)
            
            cell.secondsClosure = {
                print ("seconds finished ViewController")
                // update the view
            }
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}
