//
//  LookViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/08/02.
//

import UIKit

class LookViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    let myMovie = MovieInfo()
    
    //@IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var popularTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "둘러보기"
        let nib = UINib(nibName: "PopularTableViewCell", bundle: nil)
        popularTableView.register(nib, forCellReuseIdentifier: "PopularTableViewCell")
        
        popularTableView.delegate = self
        popularTableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "최근 본 작품"
        } else {
            return "요즘 인기 작품"
        }
    }
    
    // 테이블 뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return myMovie.movie.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : UITableViewCell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as! RecentTableViewCell
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            let item = myMovie.movie[indexPath.item]
            
            cell.configureCell(item)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = myMovie.movie[indexPath.item]
        
        vc.movieTitle = item.title
        vc.overview = item.overview
        vc.runtime = item.runtime
        vc.rate = item.rate
        vc.releaseDate = item.releaseDate
        vc.backgroundColor = .gray
        
        present(vc, animated: true)
        //navigationController?.pushViewController(vc, animated: true)
        
    }


}
