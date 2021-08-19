//
//  FavoriteCollectionViewCell.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 19.08.2021.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
    }
    @IBOutlet var favoriteBackView: UIView!
    @IBOutlet var favoriteImageMain: UIImageView!
    @IBOutlet var favoriteClikButton: UIButton!
    @IBOutlet var favoriteLabelMain: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favoriteButclicked(_ sender: Any) {
        print("test")
    }
    
}
