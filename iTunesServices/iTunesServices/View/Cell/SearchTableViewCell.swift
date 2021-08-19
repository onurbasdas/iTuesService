//
//  SearchTableViewCell.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 19.08.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }

    @IBOutlet var searchBackView: UIView!
    @IBOutlet var imageSearch: UIImageView!
    @IBOutlet var imageName: UILabel!
    @IBOutlet var imageAuthor: UILabel!
    @IBOutlet var imageDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conf()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func conf() {
        imageName.numberOfLines = 0
    }
    
}
