//
//  BookTableRepository.swift
//  Bookworm
//
//  Created by 마르 on 2023/09/06.
//

import UIKit
import RealmSwift

protocol BookTableRepositoryType: AnyObject {
    
    func fetch() -> Results<BookTable>
    func editItem(_ item: BookTable)
    func deleteItem(_ item: BookTable)
}

class BookTableRepository: BookTableRepositoryType {

    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> RealmSwift.Results<BookTable> {
        let data = realm.objects(BookTable.self).sorted(byKeyPath: "bookTitle")
        return data
    }
    
    func createItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func editItem(_ item: BookTable) { // 레코드 전체 데이터 받아와서 수정
        
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("????")
        }
    }
    
    func updateMemo(id: ObjectId, memo: String) { // 메모 부분만 바꾸기
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "memo": memo], update: .modified)
            }
        } catch {
            print("????")
        }
    }
    
    func deleteItem(_ item: BookTable) {
        
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("에러")
        }
    }
    
}
