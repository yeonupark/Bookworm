//
//  MovieCollectionViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/07/31.
//

import UIKit

//private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    var myMovie = MovieInfo()
    var colors: [UIColor] = [.systemPink, .systemOrange, .systemMint, .systemYellow, .purple, .systemBrown, .systemCyan, .systemGray, .systemIndigo]
    var searchList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "검색할 영화 제목을 입력해주세요!"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        setCollectionViewLayout()
        
        colors = colors.shuffled()
        searchList = myMovie.movie
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
        //return myMovie.movie.count
        return searchList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        //let row = myMovie.movie[indexPath.row]
        let row = searchList[indexPath.row]
        cell.titleLabel.text = row.title
        cell.posterImageView.image = UIImage(named: row.title)
        cell.rateLabel.text = String(row.rate)
        
        let heart = row.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        cell.likeButton.setImage(heart, for: .normal)
        cell.likeButton.tintColor = .white
        
        cell.designCell(color: colors[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(_ sender: UIButton){
        //myMovie.movie[sender.tag].like.toggle()
        searchList[sender.tag].like.toggle()
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //let item = myMovie.movie[indexPath.item]
        let item = searchList[indexPath.item]
        
        vc.movieTitle = item.title
        vc.overview = item.overview
        vc.runtime = item.runtime
        vc.rate = item.rate
        vc.releaseDate = item.releaseDate
        vc.backgroundColor = colors[indexPath.row]
        vc.heart = item.like
        
        //let nav = UINavigationController(rootViewController: vc)
        //present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
        
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    
}

extension MovieCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        for i in Array(0...myMovie.movie.count-1){
            if myMovie.movie[i].title.contains(searchBar.text!) {
                searchList.append(myMovie.movie[i])
                print(myMovie.movie[i].title)
            }
        }
        collectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = myMovie.movie
        searchBar.text = ""
        collectionView.endEditing(true)
        collectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        for i in Array(0...myMovie.movie.count-1){
            if myMovie.movie[i].title.contains(searchBar.text!) {
                searchList.append(myMovie.movie[i])
                print(myMovie.movie[i].title)
            }
        }
        if searchBar.text == "" {
            searchList = myMovie.movie
        }
        collectionView.reloadData()
    }

}
