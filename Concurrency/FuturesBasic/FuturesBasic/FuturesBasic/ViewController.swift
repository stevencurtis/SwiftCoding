//
//  ViewController.swift
//  DecodeJson
//
//  Created by Steven Curtis on 17/02/2021.
//

import Combine
import UIKit

final class ViewController: UIViewController {

    private let viewModel: ViewModel
    
    private lazy var text: UITextView = .init(frame: .zero)
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    func setupHierarchy() {
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupComponents() {
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.text = "Placeholder"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        viewModel.completion = { result in
//            switch result {
//            case let .success(users):
//                DispatchQueue.main.async {
//                    self.text.text = users.data.map{ "\($0.firstName) \($0.lastName): \($0.email)" }.joined(separator: "\n")
//                }
//            case .failure: break
//            }
//        }
        viewModel.download()
            .sink(receiveCompletion: {
                switch $0 {
                case .failure:
                    print("error")
                case .finished:
                    print("finished")
                }
            }, receiveValue: {
                print("Users received: \($0)")
            })
            .store(in: &subscriptions)
    }
        
    func setupConstraints() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    var cancellable: AnyCancellable?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        cancellable = generateAsyncRandomNumberFromFuture()
            .sink { number in print("Got random number \(number).") }
        Task {
            await futureWithConcurrency()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func futureWithConcurrency() async {
        let number = await generateAsyncRandomNumberFromFuture().value
        print("Got a random number \(number).")
    }
    
    func generateAsyncRandomNumberFromFuture() -> Future <Int, Never> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let number = Int.random(in: 1...10)
                promise(Result.success(number))
            }
        }
    }
}
