//
//  ViewModel.swift
//  URLSessAsync
//
//  Created by Steven Curtis on 22/06/2021.
//

import Foundation

class ViewModel {
    init() { }
    
    func retrieveUsers(from url: URL) async throws -> Users {
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Users.self, from: data)
    }
}
