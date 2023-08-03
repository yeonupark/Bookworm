//
//  PopularTableViewCell.swift
//  Bookworm
//
//  Created by 마르 on 2023/08/02.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(_ sender: Movie) {
        posterImageView.image = UIImage(named: sender.title)
        titleLabel.text = sender.title
        infoLabel.text = "★ \(sender.rate)점"
        
        
    }
}
