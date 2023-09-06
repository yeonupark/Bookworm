//
//  MovieCollectionViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Book {
    let title: String
    let image: String
    let author: String
    let price: Int
    let publisher: String
    let overview: String
    var like = false
}

class MovieCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    var bookList : [Book] = []
    //var myMovie = MovieInfo()
    var page = 1
    var isEnd = false
    
    var colors: [UIColor] = [.systemPink, .systemOrange, .systemMint, .systemYellow, .purple, .systemBrown, .systemCyan, .systemGray, .systemIndigo]
    //var searchList : [Movie] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.prefetchDataSource = self

        searchBar.delegate = self
        searchBar.placeholder = "검색할 책 제목을 입력해주세요!"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        setCollectionViewLayout()
        
        colors = colors.shuffled()
        //searchList = myMovie.movie
        
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        //let row = myMovie.movie[indexPath.row]
        let item = bookList[indexPath.item]
        
        cell.titleLabel.text = item.title
        cell.titleLabel.font = .boldSystemFont(ofSize: 14)
        
        cell.rateLabel.text = String(item.author)
        cell.rateLabel.font = .systemFont(ofSize: 14)
        
        if let url = URL(string: item.image) {
            cell.posterImageView.kf.setImage(with: url)
        }
        
//        let heart = item.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//
//        cell.likeButton.setImage(heart, for: .normal)
//        cell.likeButton.tintColor = .white
//
//        cell.likeButton.tag = indexPath.row
//        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        cell.designCell(color: .orange)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(_ sender: UIButton){
        //myMovie.movie[sender.tag].like.toggle()
        //searchList[sender.tag].like.toggle()
        
        
        collectionView.reloadData()
    }
    
    let repository = BookTableRepository()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = bookList[indexPath.item]
        vc.selectedBook = item
        
        navigationController?.pushViewController(vc, animated: true)
        
        guard let url = URL(string: item.image) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            let task = BookTable(bookTitle: item.title, author: item.author, publisher: item.publisher, price: String(item.price), imageData: imageData, bookLike: true, memo: nil)
            
            DispatchQueue.main.async {
                self.repository.createItem(task)
            }
            
        }
        
        
    }

    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
        
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func callrequest(query: String, page: Int){
        searchBar.endEditing(true)
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=20&page=\(page)"
        let header: HTTPHeaders = ["Authorization":"KakaoAK ed611cdb23909b15d68b0011e02b41a5"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                print(page)
                
                self.isEnd = json["meta"]["is_end"].boolValue // 마지막 페이지인 순간에 true가 될 것
                print(self.isEnd)
                
                for item in json["documents"].arrayValue {
                    let title = item["title"].stringValue
                    let author = item["authors"][0].stringValue
                    let image = item["thumbnail"].stringValue
                    let publisher = item["publisher"].stringValue
                    let price = item["price"].intValue
                    let overview = item["contents"].stringValue
                    
                    let book = Book(title: title, image: image, author: author, price: price, publisher: publisher, overview: overview)
                    self.bookList.append(book)
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension MovieCollectionViewController: UISearchBarDelegate, UICollectionViewDataSourcePrefetching {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bookList.removeAll()
        page = 1
        
        guard let text = searchBar.text else { return }
        callrequest(query: text, page: page)
        
//        for i in Array(0...myMovie.movie.count-1){
//            if myMovie.movie[i].title.contains(searchBar.text!) {
//                searchList.append(myMovie.movie[i])
//                print(myMovie.movie[i].title)
//            }
//        }
        
//        searchBar.endEditing(true)
        collectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searchList = myMovie.movie
        bookList.removeAll()
        searchBar.text = ""
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        bookList.removeAll()
//
//        for i in Array(0...myMovie.movie.count-1){
//            if myMovie.movie[i].title.contains(searchBar.text!) {
//                searchList.append(myMovie.movie[i])
//                print(myMovie.movie[i].title)
//            }
//        }
//        if searchBar.text == "" {
//            searchList = myMovie.movie
//        }
//        collectionView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 50 && !isEnd{
                page += 1
                callrequest(query: searchBar.text!, page: page)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("==== 취소: \(indexPaths)")
    }
}
