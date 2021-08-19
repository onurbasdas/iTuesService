//
//  MainCollectionViewCell.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet var backView: UIView!
    @IBOutlet var imageMain: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var labelMain: UILabel!
    
    var check : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conf()
    }
    
    func conf() {
        backView.layer.cornerRadius = 8
        labelMain.layer.cornerRadius = 8
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        if check == true {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            check = false
        } else {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            check = true
        }
    }
    
    
}
