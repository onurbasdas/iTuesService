//
//  DetailViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet var imageDetail: UIImageView!
    @IBOutlet var nameDetail: UILabel!
    @IBOutlet var authorDetail: UILabel!
    @IBOutlet var dateDetail: UILabel!
    @IBOutlet var favoriteBarButton: UIBarButtonItem!
    
    var check : Bool?
    var selectedItemModel : MovieDetail = MovieDetail()    
    override func viewDidLoad() {
        super.viewDidLoad()
        conf()
        favoriteBarButton.tag = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMovieDetail()
    }
    
    func conf() {
        imageDetail.kf.setImage(with: URL(string: selectedItemModel.artworkUrl100!))
        nameDetail.text = selectedItemModel.name
        authorDetail.text = selectedItemModel.artistName
        dateDetail.text = selectedItemModel.releaseDate
    }
    
    func getMovieDetail() {
        if FavoriteManager.checkIfFavorites(movieId: selectedItemModel.id ?? "") {
            self.favoriteBarButton.image = UIImage(systemName: "star.fill")
            favoriteBarButton.tag = 1
        } else {
            self.favoriteBarButton.image = UIImage(systemName: "star")
            favoriteBarButton.tag = 0
        }
    }
    
    @IBAction func favoriteBarClicked(_ sender: Any) {
        if favoriteBarButton.tag == 0 {
            FavoriteManager.saveFavoriteFilm(film: selectedItemModel)
            favoriteBarButton.image = UIImage(systemName: "star.fill")
            favoriteBarButton.tag = 1
        } else {
            FavoriteManager.deleteMovie(movieId: selectedItemModel.id ?? "")
            favoriteBarButton.image = UIImage(systemName: "star")
            favoriteBarButton.tag = 0
        }
    }
}
