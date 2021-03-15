//
//  FavouritesViewController.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import UIKit

class FavouritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var viewModel: FavouritesViewModelProtocol
    init(viewModel: FavouritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
         let view = UIView()
         self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.frame
        
        let layout = { () -> UICollectionViewFlowLayout in
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            return flowLayout
        }()
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SongCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        viewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                 self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding

        return .init(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: SongCollectionViewCell.self), for: indexPath
        ) as? SongCollectionViewCell {
            cell.configure(
                with: viewModel.favourites[indexPath.row],
                onTap: {
                    let favourite = self.viewModel.favourites[indexPath.row]
                    let viewController = MusicViewController(viewModel: MusicViewModel(album: favourite))
                    self.navigationController?.pushViewController(viewController, animated: true)
                },
                topRightAction: .init(action: { [weak self] in
                    guard let self = self else {return}
                    self.viewModel.updateFavourites(identifier: self.viewModel.favourites[indexPath.row].identifier)
                },
                icon: viewModel.isUnfavourited(
                    identifier: viewModel.favourites[indexPath.row].identifier) ? "heart" : "heart.fill"
                )
            )
            return cell
        } else {
            fatalError()
        }
    }
}

