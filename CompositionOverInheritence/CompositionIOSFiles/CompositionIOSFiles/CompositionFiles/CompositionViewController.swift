//
//  CompositionViewController.swift
//  CompositionIOSFiles
//
//  Created by Steven Curtis on 09/09/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

protocol FileHandlerReadable {
    func read(_ filename: String) -> String
}

extension FileHandlerReadable {
    func read(_ filename: String) -> String {
        return ""
    }
}

protocol FileHandlerWritable {
    func write(_ filename: String, _ contents: String)
}

protocol FileHandlerReadDict {
    func allKeysValues() -> [String: String]
}

protocol FileHandlerReadStrings {
    func allFiles() -> [String]
}

class CompositionViewController: UIViewController {
    
    typealias LFFileHandler = FileHandlerReadable & FileHandlerWritable & FileHandlerReadStrings


    class LocalFileHandler: LFFileHandler {
        func allFiles() -> [String] {
            // return list of the files
            return []
        }
        
        func read(_ filename: String) -> String {
            let ddpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let filename = ddpath.first!.appendingPathComponent(filename)
            
            var localFile = String()
            
            if let fnString = try? String(contentsOf: filename, encoding: String.Encoding.utf8)
            {
                localFile = fnString
            }
            return localFile
        }
        
        func write(_ filename: String, _ contents: String) {
            let ddpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let filename = ddpath.first!.appendingPathComponent(filename)
            do {
                try contents.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print ("\(error) Error")
            }
        }
    }
    
    class LocalUserDefaultsHandler: UDFileHandler {
        func allKeysValues() -> [String : String] {
            // return dictionary of values
            return [:]
        }
        
        func read(_ filename: String) -> String {
            return UserDefaults.standard.string(forKey: filename)!
        }
        func write(_ filename: String, _ contents: String) {
            UserDefaults.standard.set(contents, forKey: filename)
        }
    }
    
    typealias UDFileHandler = FileHandlerReadable & FileHandlerWritable
    
    let fh = LocalFileHandler()
    
    @objc func saveButtonAction() {
        fh.write("AAA.txt","BBB")
    }
    
    @objc func loadButtonAction() {
        print (fh.read("AAA.txt"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        saveButton.backgroundColor = .gray
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        let saveTap = UITapGestureRecognizer(target: self, action: #selector(saveButtonAction))
        saveButton.addGestureRecognizer(saveTap)
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        let loadButton = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        loadButton.backgroundColor = .gray
        loadButton.setTitle("Load", for: .normal)
        loadButton.setTitleColor(.black, for: .normal)
        let loadTap = UITapGestureRecognizer(target: self, action: #selector(loadButtonAction))
        loadButton.addGestureRecognizer(loadTap)
        view.addSubview(loadButton)
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        loadButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60).isActive = true
    }

}
