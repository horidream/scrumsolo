//
//  Item.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 09/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import FMDB
import CloudKit



class Item: LocalManageable, CloudManageable, CustomStringConvertible{

    var id:Int64?
    var record:CKRecord?
    var tableName:String { return "items" }
    
    static func fetch<T:Item>(_ sql: String, args: [Any]! = nil) -> [T] {
        return Const.localStorage.query(sql, args: args) { (rst) -> T in
            return T(rst)
        }
    }
    
    init(){
        
    }
    
    required init(_ rst: FMResultSet) {
        self.id = rst.longLongInt(forColumn: "id")
    }

    required init(_ record:CKRecord){
        self.record = record
    }
    
    
    func delete() {
        if let id = id{
            _ = localStorage.exe("delete from items where id = ?", args: [id])
        }
    }

    func save() {
        if let id = id,  localStorage.rowExists(id: id){
            update()
//            _ = localStorage.exe("update items set title=? where id=?", args: [title, id])
        }else{
            self.id = create()
//            if localStorage.exe("insert into items (title) values(?)", args: [title]){
//                self.id = localStorage.lastInsertRowId
//            }
        }
    }
    
    private func create()->Int64?{
        return nil
    }
    
    private func update(){
        
    }
    
    private func assembleRecord( _ record: CKRecord)->CKRecord{
        return record
    }
    
    private func getOrCreateRecord()->CKRecord{
        if let record = self.record{
            return record
        }
        let record = CKRecord(recordType: "items")
        return assembleRecord(record)
    }
    
    func cloudSave(complete:@escaping ()->Void){
        cloudStorage.modify(recordsToSave: [self.getOrCreateRecord()]) { (records, ids, error) in
            if error != nil{
                self.record = records?.first
                complete()
            }
        }
    }
    
    func cloudDelete(complete:@escaping ()->Void){
        if let id = self.record?.recordID{
            cloudStorage.modify(recordsToSave:nil, recordIDsToDelete: [id] ) { (records, ids, error) in
                if error != nil{
                    self.record = nil
                    complete()
                }
            }
        }
    }

   
    var description: String{
        return "Item - \(id ?? 0)"
    }
}




protocol Composite{
    associatedtype T
    var children:[T] { get set }
    var parent:T? { get }
    
    func addChild(_ child:T)
    func insertChild(_ child:T, at index:Int)
    func removeChild(at index:Int)
    func removeAllChild()
    func removeFromParent()
}

extension Composite{
    mutating func addChild(_ child:T){
        children.append(child)
    }

    mutating func insertChild(_ child:T, at index:Int)
    {
        children.insert(child, at: index)
    }
    
    mutating func removeChild(at index:Int){
        if( index < children.count && index >= 0){
            children.remove(at: index)
        }
    }
    
    mutating func removeAllChild(){
        children = []
    }
}

extension Composite where T:Equatable,T:Composite{
    func removeChild(_ child:T){
        if let index = children.index(where: { $0 == child}){
            removeChild(at: index)
        }
    }
    
    func removeFromParent(){
    }

}


//class ScrumItem:Item{
//    var title:String
//    init(title:String){
//        self.title = title
//        super.init()
//    }
//    
//    required init(_ record: CKRecord) {
//        self.title = record["title"] as? String ?? ""
//        super.init(record)
//    }
//    
//    required init(_ rst: FMResultSet) {
//        self.title = rst.string(forColumn: "title")
//        super.init(rst)
//    }
//}
