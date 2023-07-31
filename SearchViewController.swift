//
//  SearchViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색화면"
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        contentLabel.text = "검색 화면"
        contentLabel.textAlignment = .center
    }
    
    @objc
    func closeButtonClicked(){
        dismiss(animated: true)
    }

}
