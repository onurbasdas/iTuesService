//
//  FavoritesViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    var resultData = [BookDetail]()
    var service = Service()
    var iTunes = iTunesData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        getData()
        
        
    }
    
    func getData() {
        service.getInfo { result in
            DispatchQueue.main.async { [self] in
                self.iTunes = result!
                resultData.append(contentsOf: iTunes.results!)
                favoriteCollectionView.reloadData()
            }
        }
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        cell.loadData(user: resultData)
        cell.favoriteLabelMain.text = resultData[indexPath.row].name
        return cell
    }
    
    
}
