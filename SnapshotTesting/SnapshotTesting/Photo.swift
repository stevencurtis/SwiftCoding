//
//  Photos.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import Foundation

struct Photo: Decodable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    var pictureURL: URL? {
        return URL(string: url)
    }
}
