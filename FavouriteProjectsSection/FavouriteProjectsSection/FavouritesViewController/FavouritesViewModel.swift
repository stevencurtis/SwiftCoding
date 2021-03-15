//
//  FavouritesviewModel.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var reloadCollectionView: (() -> ())? { get set }
    func updateFavourites(identifier: String)
    func isUnfavourited(identifier: String) -> Bool
    var favourites: [Favourites] { get set }
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    var favourited: [Favourites] {
        didSet {
            reloadCollectionView?()
        }
    }
    
    lazy var favourites = {
        return (self.favourited + self.unfavourited).sorted{ $0.identifier < $1.identifier }
    }()
    
    var unfavourited: [Favourites] = []
    
    init(favourites: [Favourites]) {
        self.favourited = favourites
    }
    
    func isUnfavourited(identifier: String) -> Bool {
        return unfavourited.contains{ $0.identifier == identifier }
    }
    
    var reloadCollectionView: (() -> ())?
    
    func updateFavourites(identifier: String) {
        unfavourited = unfavourited.filter{fav in fav.identifier != identifier}
        reloadCollectionView?()
        // this would PUT to update the favourite, but here just downloads the favourites and reacts accordingly
        // the actual design of this would really rely on the API contract, and what you wish to achieve
        guard let url = URL(string: Constants.urlString) else {return}
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, urlresponse, error in
            guard let data = data else {return}
            print("JSON String: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(FavouriteResponse.self, from: data) {
                let newFavourites = decoded.favourites.sorted{ $0.identifier < $1.identifier }
                self?.unfavourited += self?.favourited.filter{ fav in !newFavourites.contains{ $0.identifier == fav.identifier } } ?? []
                self?.favourited = newFavourites
            }
        }
        )
        task.resume()
    }
}
