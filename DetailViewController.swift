//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    var movieTitle: String = "제목"
    var releaseDate: String = "날짜"
    var rate: String = ""
    var overview: String = "줄거리"
    var runtime: Int = 0
    var backgroundColor: UIColor = .white
    var heart = false
    
    let placeholderText = "메모를 작성해보세요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        title = movieTitle
        
        memoTextView.delegate = self
        designMemo()
        
        designTitle()
        designInfo()
        designOverview()
        
    }
    
    func designOverview() {
        overviewTextView.text = "줄거리:\n\(overview)"
        overviewTextView.textAlignment = .left
        overviewTextView.backgroundColor = .white
        overviewTextView.textColor = .black
        overviewTextView.isEditable = false
    }
    
    func designTitle() {
        titleLabel.text = movieTitle
        titleLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    func designInfo() {
        var text = "작가: \(releaseDate) \n출판사: \(rate) \n가격: \(runtime)원"
        if heart {
            text = "* 내가 찜한 영화 *\n\(text)"
        }
        infoLabel.text = text
        infoLabel.numberOfLines = 0
    }
    
    func designMemo() {
        memoTextView.text = placeholderText
        memoTextView.textColor = .lightGray
        memoTextView.backgroundColor = .white
        memoTextView.isEditable = true
        memoTextView.textAlignment = .left
    }
}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if memoTextView.text == placeholderText {
//            memoTextView.text = nil
//            memoTextView.textColor = .black
//        }
        // 플레이스 홀더 처리 ..
        if memoTextView.textColor == .lightGray {
            memoTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.isEmpty {
            memoTextView.text = placeholderText
            memoTextView.textColor = .lightGray
        }
    }
}
