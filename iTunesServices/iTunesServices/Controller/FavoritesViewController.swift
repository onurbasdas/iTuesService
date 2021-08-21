//
//  FavoritesViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController, FavoriteCollectionProtocol {
  
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteCollectionView.reloadData()
    }
    
    func favoriteCell(cell: UICollectionViewCell, button: UIButton) {
        let index : IndexPath = favoriteCollectionView.indexPath(for: cell)!
        let favoriteManageCell = FavoriteManager.readFavoriteMovies()[index.row]

        if FavoriteManager.checkIfFavorites(movieId: favoriteManageCell.id!) != true {
            FavoriteManager.saveFavoriteFilm(film: favoriteManageCell)
            button.setImage(UIImage(named: "starselected"), for: .normal)
            self.makeAlert(titleInput: "Favori", messageInput: "Favorilere Eklenmiştir.")
            button.tag = 1
        } else {
            FavoriteManager.deleteMovie(movieId: favoriteManageCell.id!)
            button.setImage(UIImage(named: "star"), for: .normal)
            self.makeAlert(titleInput: "Favori", messageInput: "Favorilerden Çıkarılmıştır.")
            button.tag = 0
            DispatchQueue.main.async {
                self.favoriteCollectionView.reloadData()
            }
        }
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteManager.readFavoriteMovies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        let favoriteManager = FavoriteManager.readFavoriteMovies()[indexPath.row]
                
        cell.favoriteLabelMain.text = favoriteManager.name
        cell.favoriteImageMain.kf.setImage(with: URL(string: favoriteManager.artworkUrl100!))
        cell.delegate = self
        
        if FavoriteManager.checkIfFavorites(movieId: favoriteManager.id!) {
            cell.favoriteClikButton.setImage(UIImage(named: "starselected"), for: .normal)
            cell.favoriteClikButton.tag = 1
        } else {
            cell.favoriteClikButton.setImage(UIImage(named: "star"), for: .normal)
            cell.favoriteClikButton.tag = 0
        }
        return cell
    }
    
    
}
