//
//  Bundle-decode.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 31/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

extension Bundle {
    public func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw ErrorModel(errorDescription: "\(file) missing in \(self).")
        }

        let decoder = JSONDecoder()

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw ErrorModel(errorDescription: "\(file) could not be decoded from \(self) with error: \(error).")

        }
    }
}
