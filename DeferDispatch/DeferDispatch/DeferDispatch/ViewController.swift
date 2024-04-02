//
//  ViewController.swift
//
//  Created by Steven Curtis on 17/11/2021.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var i: Item? = Item()
        i = nil
        print(i)
    }
}

class Item {
    init() {
        print("called init")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            defer { print("Dispatch 2") }
            print("Dispatch 3")
        }
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            print("Dispatch 1")
        }
        )
        print("Dispatch 4")
    }

    deinit {
        print("deinit called")
    }
}
