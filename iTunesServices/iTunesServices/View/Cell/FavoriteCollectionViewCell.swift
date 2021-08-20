//
//  FavoriteCollectionViewCell.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 19.08.2021.
//

import UIKit

protocol FavoriteCollectionProtocol: AnyObject {
    func favoriteCell(cell: UICollectionViewCell, button: UIButton)
}

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
    }
    
    weak var delegate: FavoriteCollectionProtocol?
    
    
    @IBOutlet var favoriteBackView: UIView!
    @IBOutlet var favoriteImageMain: UIImageView!
    @IBOutlet var favoriteClikButton: UIButton!
    @IBOutlet var favoriteLabelMain: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteClikButton.tag = 0
    }
    
    @IBAction func favoriteButclicked(_ sender: Any) {
        delegate?.favoriteCell(cell: self, button: favoriteClikButton)
        
    }
}
