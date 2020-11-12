//
//  ControlsViewController.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 11/11/2020.
//

import UIKit

class ControlsViewController: UIViewController {
    private var controlsViewModel: ControlsViewModel!
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillProportionally
        sv.axis = .vertical
        return sv
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["one", "two", "three"])
        seg.selectedSegmentIndex = 1
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        seg.isUserInteractionEnabled = true
        return seg
    }()
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    lazy var segmentedStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var sliderStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        return sv
    }()
    
    lazy var sliderControl: UISlider = {
        let sl = UISlider()
        sl.value = 0.1
        sl.minimumValue = 0.0
        sl.maximumValue = 5.0
        return sl
    }()
    
    lazy var button: UIButton = {
        let bt = UIButton()
        bt.setTitle("Log view model values", for: .normal)
        bt.addTarget(self, action: #selector(nextPage), for: .touchDown)
        bt.setTitleColor(.blue, for: .normal)
        bt.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return bt
    }()
    
    lazy var switchControl: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    lazy var switchLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "On"
        return lab
    }()
    
    lazy var switchStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    @objc func nextPage() {
        print ("TextField value: \(String(describing: controlsViewModel.nameValue.currentValue()))")
        print ("Slider value: \(String(describing: controlsViewModel.sliderValue.currentValue()))")
        print ("Segmmented control value: \(String(describing: controlsViewModel.segmentedValue.currentValue()))")
        print ("Button enabled value: \(String(describing: controlsViewModel.buttonEnabled.currentValue()))")
        print ("Switch value: \(String(describing: controlsViewModel.switchValue.currentValue()))")
    }
      
    lazy var nameStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "test"
        return lab
    }()
    
    lazy var segmentedLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "test"
        return lab
    }()
    
    lazy var nameTextField: UITextField = {
        let nf = UITextField()
        nf.translatesAutoresizingMaskIntoConstraints = false
        nf.backgroundColor = .red
        return nf
    }()
    
    lazy var sliderValueLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    init(viewModel: ControlsViewModel) {
        self.controlsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(to viewModel: ControlsViewModel) {
        
        viewModel.nameValue.bind(\String.self, to: nameLabel, \.text)
        viewModel.nameValue.bind(\String.self, to: nameTextField, \.text)
        
        viewModel.sliderValue.bind(\Float.self, to: sliderControl, \.value)
        let transformFloatToStringFunction: (Float) -> String = String.init(_:)
        viewModel.sliderValue.bind(\Float.self, to: sliderValueLabel, \.text, mapper: transformFloatToStringFunction)
        
        viewModel.segmentedValue.bind(\Int.self, to: segmentedControl, \.selectedSegmentIndex)
        let transformIntToStringFunction: (Int) -> String = String.init(_:)
        viewModel.segmentedValue.bind(\Int.self, to: segmentedLabel, \.text, mapper: transformIntToStringFunction)

        
        viewModel.buttonEnabled.bind(\Bool.self, to: button, \.isEnabled)
        
        viewModel.switchValue.bind(\Bool.self, to: switchControl, \.isOn)
        
        
        let transformBoolToStringFunction: (Bool) -> String = String.init(_:)
        viewModel.switchValue.bind(\Bool.self, to: switchLabel, \.text, mapper: transformBoolToStringFunction)


        viewModel.switchValue.bind(
            \Bool.self,
            to: switchLabel,
            \.text,
            mapper: Mappers.transformBoolToStringFunction )
    }


    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        self.view.addSubview(stackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(nameStackView)
        
        sliderStackView.addArrangedSubview(sliderValueLabel)
        sliderStackView.addArrangedSubview(sliderControl)
        stackView.addArrangedSubview(sliderStackView)
        
        stackView.addArrangedSubview(button)
        
        segmentedStackView.addArrangedSubview(segmentedControl)
        segmentedStackView.addArrangedSubview(segmentedLabel)
        stackView.addArrangedSubview(segmentedStackView)
        
        switchStackView.addArrangedSubview(switchControl)
        switchStackView.addArrangedSubview(switchLabel)
        stackView.addArrangedSubview(switchStackView)
        
        bind(to: controlsViewModel)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8)
        ])
    }
}




