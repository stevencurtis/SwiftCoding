//
//  MainMenuViewController.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    var mainMenuViewModel: MainMenuViewModelProtocol?
    var mainMenuView = MainMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(
        viewModel: MainMenuViewModelProtocol = MainMenuViewModel(
        userDataManager: UserDataManager())
    )
    {
        super.init(nibName: nil, bundle: nil)
        mainMenuViewModel = viewModel
    }
    
    override func loadView() {
        self.view = mainMenuView
        mainMenuView.logoutButton.addTarget(
            self,
            action: #selector(didPressLogout), for: .touchUpInside
        )
    }
    
    @objc
    private func didPressLogout() {
        mainMenuViewModel?.deleteToken()
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        // This implementation does not use the Storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.stopIndicatingActivity()
    }
}
