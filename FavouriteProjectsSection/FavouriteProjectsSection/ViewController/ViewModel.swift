//
//  ViewModel.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 19/02/2021.
//

import Foundation

protocol ViewModelProtocol {
    var favourites: [Favourites] { get set }
    func loadFavourites()
    var reloadCollectionView: (() -> ())? { get set }
}

class ViewModel: ViewModelProtocol {
    public enum Section: CaseIterable, Hashable {
         case favourites
         case albums
    }
    var favourites: [Favourites] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadCollectionView?()
            }
        }
    }
    
    var reloadCollectionView: (() -> ())?
     
    func loadFavourites() {
        guard let url = URL(string: Constants.urlString) else {return}
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, urlresponse, error in
            guard let data = data else {return}
            // print("JSON String: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(FavouriteResponse.self, from: data) {
                self?.favourites = decoded.favourites
            }
        }
        )
        task.resume()
    }
    
}
