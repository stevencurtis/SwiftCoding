//
//  ViewController.swift
//  AddFieldsToBackendResponse
//
//  Created by Steven Curtis on 13/09/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        basicFileCall()
    }

    /// A basic decoding of a .json file
    func basicFileCall() {
        let people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "People.json")
        print(people)
    }
}

