//
//  MyBookEditViewController.swift
//  Bookworm
//
//  Created by 마르 on 2023/09/05.
//

import UIKit

class MyBookEditViewController: UIViewController {
    
    var data = BookTable(bookTitle: "", author: "", publisher: "", price: "", imageData: nil, bookLike: false, memo: "")
    
    let memoTextField = {
        let view = UITextField()
        view.placeholder = "메모를 입력해보세요"
        view.textColor = .black
        view.backgroundColor = .white
        
        return view
    }()
    
    let repository = BookTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(memoTextField)
        memoTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        
        guard let memoText = memoTextField.text else { return }
        
        repository.updateMemo(id: data._id, memo: memoText)
        navigationController?.popViewController(animated: true)
    }
}
