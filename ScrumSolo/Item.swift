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
import Shifu

enum ItemState:Int{
    case todo = 0, inprogress, done
}

class Item{
    var title:String!
    var descriptions:String!
    var state:ItemState = .todo
}

class ManageableItem: Item, LocalManageable, CloudManageable, Equatable{
    static func ==(lhs: ManageableItem, rhs: ManageableItem) -> Bool {
        if let id1 = lhs.id, let id2 = rhs.id{
            return id1 == id2
        }
        return false
    }
    

    var id:Int64?
    var record:CKRecord?
    
    static let cloudStorage: CloudStorage = Shared.cloudStorage
    static let localStorage: LocalStorage = Shared.localStorage
    
    
    required init(title:String, descriptions:String = ""){
        super.init()
        self.title = title
        self.descriptions = descriptions
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
        let record = CKRecord(recordType: recordName )
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
    
    
    
    var description:String{
        return "\(type(of:self))-\(self.title!)-\(id ?? 0)"
    }
}


extension Array where Element:ManageableItem{
    func cloudSave(complete:@escaping (AsyncResponse)->Void){
        Element.cloudStorage.modify(recordsToSave: self.flatMap{ $0.getOrCreateRecord() }) { (records, ids, error) in
            if error == nil{
                zip(self, records!).forEach{ $0.0.record = $0.1 }
                complete(AsyncResponse(success: true, payload: records))
            }else{
                complete(AsyncResponse(success: false, payload: error))
            }
        }
    }
    
    func cloudDelete(complete:@escaping (AsyncResponse)->Void){
        Element.cloudStorage.modify(recordsToSave:nil, recordIDsToDelete: self.flatMap{ $0.record?.recordID } ) { (records, ids, error) in
                if error == nil{
                    self.forEach{ $0.record = nil }
                    complete(AsyncResponse(success: true, payload: nil))
                }else{
                    complete(AsyncResponse(success: false, payload: error))
                }
            }
    }

}


