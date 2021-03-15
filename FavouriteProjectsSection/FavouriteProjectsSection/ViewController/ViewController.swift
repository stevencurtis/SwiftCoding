//
//  ViewController.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 19/02/2021.
//

import UIKit

class ViewController: UICollectionViewController {
     var dataSource: UICollectionViewDiffableDataSource<ViewModel.Section, Favourites>!

     lazy var layoutSections: [LayoutSection] = []
     
     typealias Snapshot = NSDiffableDataSourceSnapshot<ViewModel.Section, Favourites>
     typealias SectionSnapshot = NSDiffableDataSourceSectionSnapshot<Favourites>
     
     let albumFavourites = [
          Favourites(identifier: "ZZZ", name: "ZZZ", image: "https://upload.wikimedia.org/wikipedia/en/d/d3/Cover_of_Weezer%27s_White_Album%2C2016.jpg"),
          Favourites(identifier: "YYY", name: "YYY", image: "https://upload.wikimedia.org/wikipedia/en/d/d3/Cover_of_Weezer%27s_White_Album%2C2016.jpg"),
          Favourites(identifier: "XXX", name: "XXX", image: "https://upload.wikimedia.org/wikipedia/en/d/d3/Cover_of_Weezer%27s_White_Album%2C2016.jpg")
     ]
     
     override func viewDidLoad() {
          super.viewDidLoad()
          title = "Your Music"
          
          let frame = self.view.frame
          collectionView = UICollectionView(
               frame: frame,
               collectionViewLayout: myCollectionViewLayout
          )
          
          collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self))
          
          collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SongCollectionViewCell.self))
          
          dataSource = UICollectionViewDiffableDataSource
          <ViewModel.Section, Favourites>(collectionView: collectionView) {
               (collectionView: UICollectionView,
                indexPath: IndexPath,
                app: AnyHashable) -> UICollectionViewCell? in
               return self.layoutSections[indexPath.section].configureCell (
                    collectionView: collectionView,
                    indexPath: indexPath,
                    item: app,
                    position: indexPath.row
               )
          }
          
//          collectionView.delegate = self
          collectionView.backgroundColor = .systemBackground
          
          layoutSections.append(
               FavouritesSection(
                    title: "Your Favourites",
                    onTap: {[weak self] idx in
                         if let favourite = self?.viewModel.favourites[idx] {
                              let viewController = MusicViewController(viewModel: MusicViewModel(album: favourite))
                              self?.navigationController?.pushViewController(viewController, animated: true)
                         }
                    },
                    onFavouriteTap: {[weak self] num in
                         self?.viewModel.loadFavourites()
                    }
               )
          )
          layoutSections.append(AlbumsSection(title: "Albums"))
          
          // create snapshot to order statements
          var snapshot = Snapshot()
          snapshot.appendSections([.favourites, .albums])
          snapshot.appendItems(viewModel.favourites, toSection: .favourites)
          snapshot.appendItems(albumFavourites, toSection: .albums)
          dataSource.apply(snapshot, animatingDifferences: true)

          viewModel.reloadCollectionView = {
               self.applySnapshot()
          }
          viewModel.loadFavourites()

          
//          applySnapshot()
          
          // self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "some_text", style: .done, target: self, action: #selector(self.updateSnapshotAction))

     }
     
     @objc func updateSnapshotAction() {
          var snapshot = dataSource.snapshot()
          snapshot.deleteSections([.albums])
          dataSource.apply(snapshot)
     }

     func applySnapshot(animatingDifferences: Bool = false) {
//          var snapshot = dataSource.snapshot()
//          dataSource.apply(snapshot)
          
          var favouritesSnapshot = SectionSnapshot()
          favouritesSnapshot.append(viewModel.favourites)
          dataSource.apply(favouritesSnapshot, to: .favourites, animatingDifferences: false)

          var albumsSnapshot = SectionSnapshot()
          albumsSnapshot.append(albumFavourites)
          dataSource.apply(albumsSnapshot, to: .albums, animatingDifferences: false)
     }

     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          configureHeader()
     }
     
     lazy var myCollectionViewLayout: UICollectionViewLayout = {
          let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
               return self.layoutSections[sectionIndex].layoutSection
          }
          return layout
     }()
     
     private var viewModel: ViewModelProtocol
     
     init(
          viewModel: ViewModelProtocol) {
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
         
     func configureHeader() {
          dataSource.supplementaryViewProvider = {
               (
                    collectionView: UICollectionView,
                    kind: String,
                    indexPath: IndexPath
               )
               -> UICollectionReusableView in
               return self.layoutSections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath,
                    title: self.layoutSections[indexPath.section].title,
                    buttonTitle:
                         self.viewModel.favourites.count > 3 && indexPath.section == 0 ?
                         "See All" :
                         nil,
                    action: {_ in
                         let viewController = FavouritesViewController(
                              viewModel: FavouritesViewModel(favourites: self.viewModel.favourites)
                         )
                         self.navigationController?.pushViewController(viewController, animated: true)
                    }
               )
          }
     }
}
