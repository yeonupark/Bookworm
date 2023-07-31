//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var contentLabel: UILabel!
    var movieTitle: String = "제목"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieTitle
        
        contentLabel.text = "상세화면"
        contentLabel.textAlignment = .center
    }
    


}
