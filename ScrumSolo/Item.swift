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
        preconditionFailure("This method must be overridden")
    }
    
    private func update(){
        preconditionFailure("This method must be overridden")
    }
    
    private func setRecordProperties( _ record: CKRecord)->CKRecord{
        preconditionFailure("This method must be overridden")
    }
    
    private func getOrCreateRecord()->CKRecord{
        if let record = self.record{
            return record
        }
        let record = CKRecord(recordType: "items")
        return setRecordProperties(record)
    }
    
    func cloudSave(complete:@escaping (AsyncResponse)->Void){
        cloudStorage.modify(recordsToSave: [self.getOrCreateRecord()]) { (records, ids, error) in
            if error != nil{
                self.record = records?.first
                complete(AsyncResponse(success: true, payload: self.record))
            }else{
                complete(AsyncResponse(success: false, payload: error))
            }
        }
    }
    
    func cloudDelete(complete:@escaping (AsyncResponse)->Void){
        if let id = self.record?.recordID{
            cloudStorage.modify(recordsToSave:nil, recordIDsToDelete: [id] ) { (records, ids, error) in
                if error != nil{
                    self.record = nil
                    complete(AsyncResponse(success: true, payload: nil))
                }else{
                    complete(AsyncResponse(success: false, payload: error))
                }
            }
        }
    }
    
    var description: String{
        return "Item - \(id ?? 0)"
    }
}



