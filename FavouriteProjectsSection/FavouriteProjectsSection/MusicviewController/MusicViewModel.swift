//
//  MusicViewModel.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import Foundation

protocol MusicViewModelProtocol {
    var album: Favourites {get}
}

class MusicViewModel: MusicViewModelProtocol {
    let album: Favourites
    init(album: Favourites) {
        self.album = album
    }
}
