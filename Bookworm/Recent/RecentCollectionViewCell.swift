//
//  RecentCollectionViewCell.swift
//  Bookworm
//
//  Created by 마르 on 2023/08/02.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentCollectionViewCell"
    
    @IBOutlet var PosterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ sender: Movie) {
        PosterImageView.image = UIImage(named: sender.title)
    }
}
