//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    var movieTitle: String = "제목"
    var releaseDate: String = "날짜"
    var rate: Float = 0
    var overview: String = "줄거리"
    var runtime: Int = 0
    var backgroundColor: UIColor = .white
    var heart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        title = movieTitle
        
        designTitle()
        designInfo()
        designOverview()
        
    }
    
    func designOverview() {
        overviewLabel.text = "줄거리:\n\(overview)"
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .left
        overviewLabel.backgroundColor = .white
        overviewLabel.textColor = .black
    }
    
    func designTitle() {
        titleLabel.text = movieTitle
        titleLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    func designInfo() {
        var text = "개봉일: \(releaseDate) \n평점: \(rate) \n러닝타임: \(runtime)분"
        if heart {
            text = "* 내가 찜한 영화 *\n\(text)"
        }
        infoLabel.text = text
        infoLabel.numberOfLines = 0
    }
}
