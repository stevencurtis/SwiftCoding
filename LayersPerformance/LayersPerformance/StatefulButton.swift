//
//  StatefulButton.swift
//  LayersPerformance
//
//  Created by Steven Curtis on 04/12/2020.
//

import UIKit

enum ButtonStatus : String {
    case enabled = "Enabled"
    case loading = "Loading"
    case disabled = "Disabled"
    case selected = "Selected"
}

@IBDesignable
class StatefulButton: UIButton {
    
    // the gradient view for the normal use of the UIButton
    private let gradientViewLayer = CAGradientLayer()
    // the gradient view for when the button is disabled or selected
    private let selectedViewLayer = CAGradientLayer()
    
    // a block to be run when called
    var completionAction: ((ButtonStatus) -> Void)?
    
    // part of the button's API, to use a callback in the containing view
    public func whenButtonClicked(completion: @escaping (ButtonStatus) -> Void) {
        completionAction = completion
    }

    // the text to be displayed on the button during loading
    @IBInspectable
    private var loadingText: String?

    // the left-hand side colour of the gradientViewLayer
    @IBInspectable
    private var color1: UIColor?
    
    // the right-hand side colour of the gradientViewLayer
    @IBInspectable
    private var color2: UIColor?
    
    // the left-hand side colour of the selectedViewLayer
    @IBInspectable
    private var selectedColor1: UIColor?
    
    // the right-hand side colour of the selectedViewLayer
    @IBInspectable
    private var selectedColor2: UIColor?
    
    // the cornerRadius of the button (and the layers contained within)
    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }
    
    // the status of the button, initially set to enabled
    private var status: ButtonStatus = .enabled
    
    //activity indicator
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView (style: UIActivityIndicatorView.Style.medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    public init (text: String, loadingText: String, color1: UIColor, color2: UIColor, selectedColor1: UIColor, selectedColor2: UIColor, cornerRadius: CGFloat, frame: CGRect)
    {
        // set the properties
        self.loadingText = loadingText
        self.color1 = color1
        self.color2 = color2
        self.selectedColor1 = selectedColor1
        self.selectedColor2 = selectedColor2
        // call super
        super.init(frame: frame)
        // call self after the call to super
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.cornerRadius = cornerRadius
        // run the setup function
        setupButton()
    }

    // a general setup for both the storyboard class and the programmatic instantiation
    func setupButton() {
        // setup requires the 4 colours for the two gradients to be set
        guard let firstGradientColor = color1?.cgColor, let secondGradientColor = color2?.cgColor, let firstSelectedColor = selectedColor1?.cgColor, let secondSelectedColor = selectedColor2?.cgColor else {
            return
        }
        
        // set the frame of the gradient view
        gradientViewLayer.frame = self.bounds
        // set the gradientViewLayer colours
        gradientViewLayer.colors = [firstGradientColor, secondGradientColor]
        // set the corner radius
        gradientViewLayer.cornerRadius = self.cornerRadius
        // the start point of the gradient
        gradientViewLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        // the end point of the gradient
        gradientViewLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // insert the gradientViewLayer as a sublayer
        self.layer.insertSublayer(gradientViewLayer, at: 0)
        
        // set the frame of the selectedViewLayer
        selectedViewLayer.frame = self.bounds
        // set the selectedViewLayer colours
        selectedViewLayer.colors = [firstSelectedColor, secondSelectedColor]
        selectedViewLayer.cornerRadius = self.cornerRadius
        // the start point of the gradient
        selectedViewLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        // the end point of the gradient
        selectedViewLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // insert the selectedViewLayer as a sublayer
        self.layer.insertSublayer(selectedViewLayer, at: 0)
        
        // setup the offset for the shadow
        layer.shadowOffset = CGSize(width: 0, height: 3)
        // setup the radius for the shadow
        layer.shadowRadius = 3
        // setup the opacity of the shadow
        layer.shadowOpacity = 0.3
        // setup the colour of the shadow
        layer.shadowColor = UIColor.black.cgColor

        // property for either side of the indicator
        let indicatorSide: CGFloat = 15
        // setup the frame of the indicator
        indicator.frame = CGRect(x: indicatorSide / 2, y: self.frame.height / 2 - indicatorSide / 2 , width: indicatorSide, height: indicatorSide)
        // setup the colour of the indicator
        indicator.color = UIColor.gray
        // insert the indicator as the subclass
        self.addSubview(indicator)
        // bring the indicator to the front
        indicator.bringSubviewToFront(self)
        // add a target to the button
        self.addTarget(self, action: #selector(setNextAction(_:)), for: [.touchUpInside])
    }
    
    @IBAction func setNextAction(_ sender: StatefulButton? = nil) {
        // switch according to the button
        switch sender?.status {
        case .enabled:
            setLoading()
        case .loading:
            setEnabled()
        case .disabled:
            break
        case .selected:
            setEnabled()
        default:
            break
        }
    }
    
    @IBAction func setSelectedAction(_ sender: UIButton? = nil) {
        setSelected()
    }
    
    @IBAction func setLoadingAction(_ sender: UIButton? = nil) {
        setLoading()
    }
    
    @IBAction func setDeSelectedAction(_ sender: UIButton? = nil) {
        setEnabled()
    }
    
    func setEnabled() {
        // hide the indicator
        indicator.isHidden = true
        // stop the indicator animating
        indicator.stopAnimating()
        // re-enable user interaction
        self.isUserInteractionEnabled = true
        // set the title for the text
        self.setTitle(loadingText, for: .disabled)
        // show the gradient
        self.showGradient()
        // enable the button
        self.isEnabled = true
        // set the status of the button
        self.status = .enabled
        // hit the completion action, if it exists
        completionAction?(self.status)
    }
    
    private func setSelected() {
        // hide the gradient
        self.hideGradient()
        // disable the button
        self.isEnabled = false
        // set the status
        self.status = .selected
        // hit the completion action, if it exists
        completionAction?(self.status)
    }
    
    func setLoading() {
        // hide the activity indicator
        indicator.isHidden = false
        // start the animation for the activity indicator
        indicator.startAnimating()
        // stop user interaction
        self.isUserInteractionEnabled = false
        // set the button title
        self.setTitle(loadingText, for: .disabled)
        // disable the button
        self.isEnabled = false
        // set the status
        self.status = .loading
        // hide the gradient
        self.hideGradient()
        // hit the completion action, if it exists
        completionAction?(self.status)
    }
    
    // hide the gradient
    private func hideGradient() {
        gradientViewLayer.isHidden = true
    }
    
    // show the gradient
    func showGradient() {
        gradientViewLayer.isHidden = false
    }
    
    // called after a view's layout is updated
    override func layoutSubviews() {
        super.layoutSubviews()
        // call the setup when the layout is updated, perhaps due to an orientation change
        setupButton()
    }
}

