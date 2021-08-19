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
    var selectedItemModel : Results = Results()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conf()
    }
    
    func conf() {
        imageDetail.kf.setImage(with: URL(string: selectedItemModel.artworkUrl100!))
        nameDetail.text = selectedItemModel.name
        authorDetail.text = selectedItemModel.artistName
        dateDetail.text = selectedItemModel.releaseDate
    }
    
    @IBAction func favoriteBarClicked(_ sender: Any) {
        if check == true {
            favoriteBarButton.image = UIImage(systemName: "star")
            check = false
        } else {
            favoriteBarButton.image = UIImage(systemName: "star.fill")
            check = true
        }
    }
}
