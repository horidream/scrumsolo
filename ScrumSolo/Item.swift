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


enum ItemState:Int{
    case todo = 0, inprogress, done
}

class Item{
    var title:String!
    var descriptions:String!
    var state:ItemState = .todo
}

class ManageableItem: Item, LocalManageable, CloudManageable{


    
    var id:Int64?
    var record:CKRecord?
    
    static let cloudStorage: CloudStorage = Shared.cloudStorage
    static let localStorage: LocalStorage = Shared.localStorage
    
    
    override init(){
        super.init()
        self.title = "Untitled"
        self.descriptions = ""
    }
    
    required init(_ rst: FMResultSet) {
        
        super.init()
        self.title = rst.string(forColumn: "title")
        self.descriptions = rst.string(forColumn:"descriptions")
        self.id = rst.longLongInt(forColumn: "id")
        self.state = ItemState(rawValue: rst.long(forColumn: "state")) ?? .todo
    }
    
    required init(_ record:CKRecord){
        super.init()
        self.title = record["title"] as! String
        self.descriptions = record["descriptions"] as! String
        self.state = ItemState(rawValue: record["state"] as! Int) ?? .todo
        self.record = record
    }
    
    
    final func delete() {
        if let id = id{
            _ = localStorage.exe("delete from items where id = ?", args: [id])
        }
    }
    
    final func save() {
        if let id = id,  localStorage.rowExists(id: id){
            update()
            
        }else{
            self.id = create()
        }
    }
    
    func create()->Int64?{
        preconditionFailure("This method must be overridden")
    }
    
    func update(){
        preconditionFailure("This method must be overridden")
    }
    
    func setRecordProperties( _ record: CKRecord)->CKRecord{
        preconditionFailure("This method must be overridden")
    }
    
    fileprivate func getOrCreateRecord()->CKRecord{
        if let record = self.record{
            return record
        }
        let record = CKRecord(recordType: "items")
        return setRecordProperties(record)
    }
    
    final func cloudSave(complete:@escaping (AsyncResponse)->Void){
        cloudStorage.modify(recordsToSave: [self.getOrCreateRecord()]) { (records, ids, error) in
            if error == nil{
                self.record = records?.first
                complete(AsyncResponse(success: true, payload: self.record))
            }else{
                complete(AsyncResponse(success: false, payload: error))
            }
        }
    }
    
    final func cloudDelete(complete:@escaping (AsyncResponse)->Void){
        if let id = self.record?.recordID{
            cloudStorage.modify(recordsToSave:nil, recordIDsToDelete: [id] ) { (records, ids, error) in
                if error == nil{
                    self.record = nil
                    complete(AsyncResponse(success: true, payload: nil))
                }else{
                    complete(AsyncResponse(success: false, payload: error))
                }
            }
        }
    }
}


extension ManageableItem: CustomStringConvertible{
    static func fetch(_ sql:String, args:[Any]! = [])->[ManageableItem]{
        return Shared.localStorage.query(sql, args: args) { (rst) -> ManageableItem? in
            return self.init(rst)
        }
    }
    
    convenience init(title:String, descriptions:String = ""){
        self.init()
        self.title = title
        self.descriptions = descriptions
    }
    
    var description:String{
        return "\(type(of:self))-\(self.title!)(\(self.state))"
    }
}


extension Array where Element:ManageableItem{
    func cloudSave(complete:@escaping (AsyncResponse)->Void){
        Shared.cloudStorage.modify(recordsToSave: self.flatMap{ $0.getOrCreateRecord() }) { (records, ids, error) in
            if error == nil{
                zip(self, records!).forEach{ $0.0.record = $0.1 }
                complete(AsyncResponse(success: true, payload: records))
            }else{
                complete(AsyncResponse(success: false, payload: error))
            }
        }
    }
    
    func cloudDelete(complete:@escaping (AsyncResponse)->Void){
        Shared.cloudStorage.modify(recordsToSave:nil, recordIDsToDelete: self.flatMap{ $0.record?.recordID } ) { (records, ids, error) in
                if error == nil{
                    self.forEach{ $0.record = nil }
                    complete(AsyncResponse(success: true, payload: nil))
                }else{
                    complete(AsyncResponse(success: false, payload: error))
                }
            }
    }

}


