//
//  MainViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController, FavoriteProtocol {
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var service = Service()
    var resultData = [MovieDetail]()
    var iTunes = iTunesData()
    var detailsInfo : MovieDetail = MovieDetail()
    var movie : MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
        service.getInfo { result in
            DispatchQueue.main.async { [self] in
                self.iTunes = result!
                resultData.append(contentsOf: iTunes.results!)
                mainCollectionView.reloadData()
            }
        }
    }
    
    func favoriteClicked(cell: UICollectionViewCell, button: UIButton) {
        let index : IndexPath = mainCollectionView.indexPath(for: cell)!
        if FavoriteManager.checkIfFavorites(movieId: resultData[index.row].id!) != true {
            FavoriteManager.saveFavoriteFilm(film: resultData[index.row])
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            button.tag = 1
        } else {
            FavoriteManager.deleteMovie(movieId: resultData[index.row].id!)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.tag = 0
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        if FavoriteManager.checkIfFavorites(movieId: resultData[indexPath.row].id!) {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cell.favoriteButton.tag = 1
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            cell.favoriteButton.tag = 0
        }
        cell.delegate = self
        cell.labelMain.text = resultData[indexPath.item].name
        cell.imageMain.kf.setImage(with: URL(string: resultData[indexPath.item].artworkUrl100!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailsInfo = resultData[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.selectedItemModel = detailsInfo
        }
    }
}
