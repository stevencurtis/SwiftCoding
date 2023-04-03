//
//  Decodable+json.swift
//  JSONBasicsTests
//
//  Created by Steven Curtis on 29/03/2023.
//

import Foundation

extension Decodable {
    public static func json(contentsOfFile file: String, bundle: Bundle) -> Self {
        let path = bundle.path(forResource: file, ofType: "json")!
        let content = try! String(contentsOfFile: path, encoding: .utf8)
        return json(content)
    }

    public static func json(_ json: String) -> Self {
        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)!
        let model = try! decoder.decode(Self.self, from: data)
        return model
    }
}
