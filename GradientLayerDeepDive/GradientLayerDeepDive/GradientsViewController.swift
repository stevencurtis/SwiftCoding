//
//  GradientsViewController.swift
//  GradientLayerDeepDive
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class GradientsViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var colourTableView: UITableView!
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var resultView: UIView!
    
    var locations: [NSNumber] = [0.5]
    var colours: [UIColor] = [UIColor.red, UIColor.blue]
    var gradient: CAGradientLayer = CAGradientLayer()
    var currentColour: UIColor = UIColor(displayP3Red: 255 / 255, green: 59 / 255, blue: 48 / 255, alpha: 1)
    var endPoint: Point = Point.centerLeft
    var startPoint: Point = Point.centerRight
    
        @IBOutlet weak var startpointLabel: UILabel!
    
    @IBAction func startpointXValue(_ sender: UISlider) {
        startPoint = Point.custom(point: CGPoint(x: CGFloat(sender.value), y: startPoint.point.y))
        updateGradientStartPoint()
        updateLabel()
    }
    
    @IBAction func startpointYValue(_ sender: UISlider) {
        startPoint = Point.custom(point: CGPoint(x: startPoint.point.x, y: CGFloat(sender.value)))
        updateGradientStartPoint()
        updateLabel()
    }
    
    @IBOutlet weak var endpointLabel: UILabel!

    
    @IBAction func endpointXValue(_ sender: UISlider) {
        endPoint = Point.custom(point: CGPoint(x: CGFloat(sender.value), y: endPoint.point.y))
        updateGradientEndPoint()
        updateLabel()
    }
    
    @IBAction func endpointYValue(_ sender: UISlider) {
        endPoint = Point.custom(point: CGPoint(x: endPoint.point.x, y: CGFloat(sender.value)))
        updateGradientEndPoint()
        updateLabel()
    }

    func updateLabel() {
        startpointLabel.text = "\(startPoint.point.x.StringFromFloat ?? ""),\(startPoint.point.y.StringFromFloat ?? "")"
        endpointLabel.text = "\(endPoint.point.x.StringFromFloat ?? ""),\(endPoint.point.y.StringFromFloat ?? "")"
    }
    
    var currentLocation: NSNumber = 0.5 {
        didSet {
            let locationStr = currentLocation.StringFromFloat ?? ""
            locationLabel.text = "\( locationStr )"
        }
    }

    @IBAction func addLocationAction(_ sender: UIButton) {
        locations.append(currentLocation)
        locationTableView.reloadData()
        updateGradientLocations()
    }
    
    @IBAction func locationSliderAction(_ sender: UISlider) {
        currentLocation = NSNumber(value: sender.value)
    }
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case centerLeft, centerRight
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
                case .topRight: return CGPoint(x: 1, y: 0)
                case .topLeft: return CGPoint(x: 0, y: 0)
                case .bottomRight: return CGPoint(x: 1, y: 1)
                case .bottomLeft: return CGPoint(x: 0, y: 1)
                case .centerLeft: return CGPoint(x: 0.5, y: 0.0)
                case .centerRight: return CGPoint(x: 0.5, y: 1.0)
                case .custom(let point): return point
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gradient.colors = colours.map{ $0.cgColor }
        gradient.frame = resultView.bounds
        gradient.locations = locations
        resultView.layer.insertSublayer(gradient, at: 0)
        gradient.endPoint = Point.centerLeft.point
        gradient.startPoint = Point.centerRight.point
    }
    
    func updateGradientEndPoint() {
        let animation = CABasicAnimation(keyPath: "endPoint")
        animation.fromValue = gradient.endPoint
        animation.toValue = endPoint.point
        animation.duration = 5.0
        self.gradient.endPoint = endPoint.point
        self.gradient.add(animation, forKey:"animateendpoint")
    }
    
    func updateGradientStartPoint() {
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = gradient.startPoint
        animation.toValue = startPoint.point
        animation.duration = 5.0
        self.gradient.startPoint = startPoint.point
        self.gradient.add(animation, forKey:"animatestartpoint")
    }
    
    func updateGradientLocations() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = gradient.locations
        animation.toValue = locations
        animation.duration = 5.0
        self.gradient.locations = locations
        self.gradient.add(animation, forKey:"animatelocations")
    }
    
    func updateGradientColours() {
        let animation = CABasicAnimation(keyPath: "colors")
        let newColors = colours.map {$0.cgColor}
        animation.fromValue = gradient.colors
        animation.toValue = newColors
        animation.duration = 5.0
        animation.repeatCount = 0
        self.gradient.colors = newColors
        self.gradient.add(animation, forKey:"animatecolours")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourTableView.delegate = self
        colourTableView.dataSource = self
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        locationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "location")
        colourTableView.register(UITableViewCell.self, forCellReuseIdentifier: "colour")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "picker" {
            if let dest = segue.destination as? CreateViewController {
                dest.delegate = self
            }
        }
    }
}

extension GradientsViewController: GradientsDelegate {
    func chosenColours(colour: UIColor) {
        currentColour = colour
        
        colours.append(currentColour)
        colourTableView.reloadData()
        updateGradientColours()
    }
}

extension GradientsViewController: UITableViewDelegate { }

extension GradientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == locationTableView {
            return locations.count
        }
        return colours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == locationTableView {
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "location")
            cell?.textLabel?.text = locations[indexPath.row].StringFromFloat
            return cell!
        }
        
        let cell = colourTableView.dequeueReusableCell(withIdentifier: "colour")
        let cellColour = colours[indexPath.row]
        cell?.backgroundColor = cellColour
        return cell!
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            if tableView == locationTableView {
                self.locations.remove(at: indexPath.row)
                self.locationTableView.deleteRows(at: [indexPath], with: .automatic)
                updateGradientLocations()
                return
            }
            self.colours.remove(at: indexPath.row)
            self.colourTableView.deleteRows(at: [indexPath], with: .automatic)
            updateGradientColours()
            return
        }
    }
    
}

