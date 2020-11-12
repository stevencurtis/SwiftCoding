//
//  ViewController.swift
//  TwoWayBinding
//
//  Created by Steven Curtis on 04/11/2020.
//

import UIKit

class ViewController: UIViewController {
    private var viewModel: ViewModel!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: ViewModel) {
        // fires when viewmodel.name changes (obvs.)
        viewModel.firstName.observe(on: firstTF, completion: {val in
            self.firstTF.text = val
        })
        secondTF.bind(with: viewModel.secondName)
        secondTF.text = "AA"
        viewModel.thirdName.bind(\String.self, to: thirdTF, \.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         bind(to: viewModel)
    }
    
    let firstTF = UITextField(frame: .zero)
    let secondTF = UITextField(frame: .zero)
    let thirdTF = UITextField(frame: .zero)
    let stackView = UIStackView(frame: .zero)
    let nextButton = UIButton(frame: .zero)

    @objc func nextPage() {
        let cvc = ControlsViewController(viewModel: ControlsViewModel())
        self.navigationController?.pushViewController(cvc, animated: true)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
        firstTF.backgroundColor = .blue
        secondTF.backgroundColor = .purple
        thirdTF.backgroundColor = .systemPink

        firstTF.delegate = self
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        nextButton.setTitle("View Multiple Controls", for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchDown)
        firstTF.translatesAutoresizingMaskIntoConstraints = false
        secondTF.translatesAutoresizingMaskIntoConstraints = false
        thirdTF.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackView.addArrangedSubview(firstTF)
        self.stackView.addArrangedSubview(secondTF)
        self.stackView.addArrangedSubview(thirdTF)
        self.stackView.addArrangedSubview(nextButton)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstTF {
             viewModel.firstName.value = textField.text! + string
        }
        return true
    }
}

