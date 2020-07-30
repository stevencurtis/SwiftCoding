//
//  CreateViewController.swift
//  GradientLayerDeepDive
//
//  Created by Steven Curtis on 17/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit


struct Colour {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}

protocol GradientsDelegate {
    func chosenColours(colour: UIColor)
}

class CreateViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var alphaView: UIView!
    
    @IBOutlet weak var combinedView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    
    var delegate: GradientsDelegate?
    
    var greenValue: CGFloat = 0.5 {
        didSet {
            updateViews()
        }
    }
    var blueValue: CGFloat = 0.5 {
           didSet {
               updateViews()
           }
       }
    var redValue: CGFloat = 0.5 {
           didSet {
               updateViews()
           }
       }
    
    var alphaValue: CGFloat = 0.5 {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func redSliderAction(_ sender: UISlider) {
        redValue = CGFloat(sender.value)
    }
    
    func updateViews() {
        redView.backgroundColor = UIColor(displayP3Red: redValue, green: 0, blue: 0, alpha: 1)
        greenView.backgroundColor = UIColor(displayP3Red: 0, green: greenValue, blue: 0, alpha: 1)
        blueView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: blueValue, alpha: 1)
        alphaView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: alphaValue)

        combinedView.backgroundColor = UIColor(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
        let redInt = Int(redValue * 255)
        redLabel.text = "R: \(redInt)"

        let greenInt = Int(greenValue * 255)
        greenLabel.text = "G: \(greenInt)"
        
        let blueInt = Int(blueValue * 255)
        blueLabel.text = "B: \(blueInt)"
        
        let alphaStr = alphaValue.StringFromFloat ?? ""
        
        alphaLabel.text = "Alpha: \( alphaStr )"
    }
    
    @IBAction func greenSliderAction(_ sender: UISlider) {
        greenValue = CGFloat(sender.value)
    }
    
    @IBAction func blueSliderAction(_ sender: UISlider) {
        blueValue = CGFloat(sender.value)
    }
    
    @IBAction func alphaSliderAction(_ sender: UISlider) {
        alphaValue = CGFloat(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delaysContentTouches = false
        
        redView.backgroundColor =  UIColor(displayP3Red: 155/255, green: 0, blue: 0, alpha: 1)
        greenView.backgroundColor =  UIColor(displayP3Red: 0, green: 155/255, blue: 0, alpha: 1)
        blueView.backgroundColor =  UIColor(displayP3Red: 0, green: 0, blue: 155/255, alpha: 1)

        alphaView.backgroundColor =  UIColor(displayP3Red: 155/255, green: 155/255, blue: 155/255, alpha: 0.5)

        let tapRedGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapRed))
        redView.addGestureRecognizer(tapRedGesture)
        
        let tapBlueGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBlue))
        blueView.addGestureRecognizer(tapBlueGesture)
        
        let tapGreenGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGreen))
        greenView.addGestureRecognizer(tapGreenGesture)
    }
    
    @objc func tapGreen() {
        delegate?.chosenColours(colour:
            UIColor(displayP3Red: 0.0, green: greenValue, blue: 0.0, alpha: 1.0)
        )
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapBlue() {
        delegate?.chosenColours(colour:
            UIColor(displayP3Red: 0.0, green: 0.0, blue: blueValue, alpha: 1.0)
        )
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapRed() {
        delegate?.chosenColours(colour:
            UIColor(displayP3Red: redValue, green: 0.0, blue: 0.0, alpha: 1.0)
        )
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickColourAction(_ sender: UIButton) {
        delegate?.chosenColours(colour:
            UIColor(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        )
        self.dismiss(animated: true, completion: nil)
    }
}
