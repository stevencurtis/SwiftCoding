//
//  ViewController.swift
//  StoryboardInstantiateProperties
//
//  Created by Steven Curtis on 09/02/2024.
//

import UIKit

final class ViewController: UIViewController {
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init?(coder: NSCoder, name: String) {
        self.name = name
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SecondViewController {
            viewController.injectedProperty = "This will be injected."
        }
    }

    @IBAction private func fromSBAction() {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    @IBAction private func fromNav() {
            let storyboard = UIStoryboard(name: "NavBarStoryboard", bundle: nil)
            guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
                let secondViewController = SecondViewController(coder: coder, text: "test")
                return secondViewController
            }) else { return }
            present(viewController, animated: true)
    }
    
    @IBAction private func fromDirectAction() {
        let storyboard = UIStoryboard(name: "NextStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            let secondViewController = SecondViewController(coder: coder, text: "test")
            return secondViewController
        }) else { return }
        present(viewController, animated: true)
    }
    
    @IBAction func doesntCrash() {
        let storyboard = UIStoryboard(name: "NextStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            let secondViewController = SecondViewController(coder: coder, text: "test")
            return secondViewController
        }) else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
