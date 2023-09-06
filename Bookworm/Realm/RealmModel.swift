//
//  RealmModel.swift
//  Bookworm
//
//  Created by 마르 on 2023/09/05.
//

import UIKit
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bookTitle: String
    @Persisted var author: String?
    @Persisted var publisher: String?
    @Persisted var price: String?
    //@Persisted var bookImage: String?
    @Persisted var image: Data?
    @Persisted var memo : String?
    
    convenience init(bookTitle: String, author: String?, publisher: String?, price: String?, imageData: Data?, bookLike: Bool, memo: String?) {
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.price = price
        self.image = imageData
        self.memo = memo
    }
}
