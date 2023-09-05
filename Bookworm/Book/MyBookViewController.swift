//
//  MyBookViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class MyBookViewController: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.register(MyBookTableViewCell.self, forCellReuseIdentifier: "MyBookTableViewCell")
        
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 150
        
        return view
    }()
    
    let navBar = {
        let view = UINavigationBar()
        
        return view
    }()
    
    let realm = try! Realm()
    var tasks: Results<BookTable>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "내 서재"
        tabBarItem.image = UIImage(systemName: "book")
        
        tasks = realm.objects(BookTable.self)
        
        view.addSubview(navBar)
        view.addSubview(tableView)
        navBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension MyBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyBookTableViewCell", for: indexPath) as? MyBookTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        cell.titleLabel.text = data.bookTitle
        cell.author.text = data.author
        cell.publisher.text = "[\(data.publisher ?? "")]"
        cell.price.text = "\(data.price ?? "")원"
        cell.memo.text = "메모: \(data.memo ?? "")"
        guard let imageData = data.imageData else { return cell }
        cell.bookImage.image = UIImage(data: imageData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = MyBookEditViewController()
        vc.data = self.tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let data = self.tasks[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completionHandler in
            do {
                try self.realm.write {
                    self.realm.delete(data)
                }
            } catch {
                print("에러")
            }
            tableView.reloadData()
        }
        delete.image = UIImage(systemName: "minus.circle")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
