//
//  RecentTableViewCell.swift
//  Bookworm
//
//  Created by 마르 on 2023/08/02.
//

import UIKit

class RecentTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    static let identifier = "RecentTableViewCell"
    let myMovie = MovieInfo()
    
    @IBOutlet var recentCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "RecentCollectionViewCell", bundle: nil)
        recentCollectionView.register(nib, forCellWithReuseIdentifier: "RecentCollectionViewCell")
        
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        configureRecentLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMovie.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as! RecentCollectionViewCell
        
        let item = myMovie.movie[indexPath.item]
        cell.configureCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        let item = myMovie.movie[indexPath.item]

        vc.movieTitle = item.title
        vc.overview = item.overview
        vc.runtime = item.runtime
        vc.rate = item.rate
        vc.releaseDate = item.releaseDate
        vc.backgroundColor = .gray

        //present(vc,animated: true)
        //navigationController?.pushViewController(vc, animated: true)
    }
    func configureRecentLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 170)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        recentCollectionView.collectionViewLayout = layout
    }
}
