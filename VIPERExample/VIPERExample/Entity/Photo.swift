//
//  Photos.swift
//  VIPERExample
//
//  Created by Steven Curtis on 22/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct Photo: Decodable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
