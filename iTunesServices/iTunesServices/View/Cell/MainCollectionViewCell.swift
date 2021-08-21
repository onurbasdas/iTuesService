//
//  MainCollectionViewCell.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit

protocol FavoriteProtocol: AnyObject {
    func favoriteClicked(cell: UICollectionViewCell, button: UIButton)
}

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
    
    weak var delegate: FavoriteProtocol?

    
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
        favoriteButton.tag = 0
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.favoriteClicked(cell: self, button: favoriteButton)
    }
    
    
}
