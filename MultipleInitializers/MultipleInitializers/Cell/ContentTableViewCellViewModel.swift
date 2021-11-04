//
//  ContentTableViewCellViewModel.swift
//  MultipleInitializers
//
//  Created by Steven Curtis on 02/11/2021.
//

import Foundation
import UIKit

struct ContentTableViewCellViewModel {
    let image: String?
    let title: String?
    let url: URL?

    enum CellContent {
        case image(ImageType)
        case title(String)
    }
    
    enum ImageType {
        case name(String)
        case url(URL)
    }
    
    init(content: CellContent) {
        switch content {
        case let .image(image):
            switch image {
            case let .name(name):
                self.image = name
                self.url = nil
                self.title = nil
            case let .url(url):
                self.url = url
                self.image = nil
                self.title = nil
            }
        case let .title(title):
            self.title = title
            self.image = nil
            self.url = nil
        }
    }
}
