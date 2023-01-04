//
//  ViewController.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 31/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private var httpManager: AnyNetworkManager<URLSession>?
    
    func decode<T: Decodable>(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            // will silently fail and return nil
            return nil
        }
    }
    
    /// A basic network call using the httpManager
    func basicCall() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/8")!
        
        httpManager?.get(url: url, completionBlock: {res in
            print (res)
            
            switch res {
            case .success(let data) :
                let _: ToDoModel? = self.decode(data: data)
                break
            case .failure:
                break
            }
        })
    }
    
    let data = """
    [
      {
          "timestamp": "2019-01-18T10:15:29.979Z",
          "unique_key": "1"
      },
        {
            "timestamp": "2019-01-18T10:15:32.250Z",
            "unique_key": "2"
      }
    ]
    """.data(using: .utf8)!
    
    func timeModelInfiniteLoop() {
        // don't try this at home, kids
        let times: TimeModelInfiniteLoop = try! Bundle.main.decode(TimeModelInfiniteLoop.self, from: "TimesMissingTimeStamp.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
        print(times)
    }
    
    func missingFieldsFile() {
        let times: [TimeModel] = try! Bundle.main.decode([TimeModel].self, from: "TimesMissingTimeStamp.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
        print(times)
    }
    
    func missingFieldsSolved() {
        let times: TimeModelCodable = try! Bundle.main.decode(TimeModelCodable.self, from: "TimesMissingTimeStamp.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
        print(times)
    }
    
    func timestampFile() {
        let times: [TimeModel] = try! Bundle.main.decode([TimeModel].self, from: "Times.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
        print(times)
    }
    
    /// A basic decoding of a .json file
    func basicFileCall() {
        let people: [PeopleModel] = try! Bundle.main.decode([PeopleModel].self, from: "Peeps.json")
        print(people)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let network = NetworkManager(session: URLSession.shared)
        self.httpManager = AnyNetworkManager(manager: network)
        self.view.backgroundColor = .orange
//         basicFileCall()
        // timestampFile()
//         missingFieldsFile()

//         timeModelInfiniteLoop()
        missingFieldsSolved()
    }
}
