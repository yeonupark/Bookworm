//
//  MyBookTableViewCell.swift
//  Bookworm
//
//  Created by 마르 on 2023/09/05.
//

import UIKit
import SnapKit

final class MyBookTableViewCell: UITableViewCell {
    
    let bookImage = {
        let view = UIImageView()
        view.backgroundColor = .systemGreen
        
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.numberOfLines = 0
        
        return view
    }()
    
    let author = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        
        return view
    }()
    
    let publisher = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        
        return view
    }()
    
    let price = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        
        return view
    }()
    
    let memo = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .brown
        return view
    }()
    
    static let identifier = "MyBookTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        for item in [bookImage, titleLabel, author, publisher, price, memo] {
            contentView.addSubview(item)
        }
    }
    
    func setConstraints() {
        bookImage.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.trailing.equalTo(bookImage.snp.leading)
            
        }
        author.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        publisher.snp.makeConstraints { make in
            make.leading.equalTo(author.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        price.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(author.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        memo.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(price.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
    }
    
}
