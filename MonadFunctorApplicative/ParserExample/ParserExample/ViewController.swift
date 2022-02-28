//
//  ViewController.swift
//  ParserExample
//
//  Created by Steven Curtis on 24/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "http://pic3.zhimg.com/8161ba9638273e0fb1a0201789d22d8e_m.jpg"
        let urls = URL(string: urlString)

        let parser: ((NSData?) -> [String: String])? = { _ in
            return ["test": "ViewController"]
        }

        let parsed = urls.flatMap{ Optional.Some(NSData(contentsOf: $0)).apply(f: parser) }
    }

    func processUrl(
        urlString: String,
        parser: ((NSData?) -> [String: String])?
    ) -> [String: String]?
    {
        if let url = URL(string: urlString),
           let responseData = NSData(contentsOf: url),
           let parser = parser {
            return parser(responseData)
        } else {
            return nil
        }
    }
}

enum Optional<T> {
    case Some(T), Nil
    
    func map<U>(_ f: (T) -> U) -> U? {
        switch self {
        case .Some(let x): return f(x)
        case .Nil: return .none
        }
    }
}

extension Optional {
    func apply<U>(f: ((T) -> U)?) -> U? {
        return f.flatMap {
            self.map($0)
        }
    }
}
