//
//  FavoritesViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    var resultData = [MovieDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)

    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        if FavoriteManager.checkIfFavorites(movieId: resultData[indexPath.row].id!) {
            FavoriteManager.readFavoriteMovies()
            cell.favoriteLabelMain.text = resultData[indexPath.row].name
        }
        return cell
    }
    
    
}
