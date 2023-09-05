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
    
    var selectedBook = Book(title: "", image: "", author: "", price: 0, publisher: "", overview: "")
    
    var bookTitle: String = "제목"
    var publisher: String = "날짜"
    var author: String = ""
    var overview: String = "줄거리"
    var price: Int = 0
    var imagePath: String = ""
    var backgroundColor: UIColor = .systemGreen
    var heart = false
    
    let placeholderText = "메모를 작성해보세요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        title = bookTitle
        getInfo()
        
        memoTextView.delegate = self
        designMemo()
        
        designTitle()
        designInfo()
        designOverview()
        
    }
    
    func getInfo() {
        bookTitle = selectedBook.title
        overview = selectedBook.overview
        price = selectedBook.price
        publisher = selectedBook.publisher
        author = selectedBook.author
        imagePath = selectedBook.image
        backgroundColor = .orange

    }
    
    func designOverview() {
        overviewTextView.text = "줄거리:\n\(overview)"
        overviewTextView.textAlignment = .left
        overviewTextView.backgroundColor = .white
        overviewTextView.textColor = .black
        overviewTextView.isEditable = false
    }
    
    func designTitle() {
        titleLabel.text = bookTitle
        titleLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    func designInfo() {
        var text = "작가: \(author) \n출판사: \(publisher) \n가격: \(price)원"
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
