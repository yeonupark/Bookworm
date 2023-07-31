//
//  MovieCollectionViewCell.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
