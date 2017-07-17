//
//  Story.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 27/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import Shifu
import CloudKit
import FMDB

class Story:ManageableItem{
    var priority:UInt64 = 0
    weak var parent:Epic?
    var children:[Task] = []
    
    required init(_ record: CKRecord) {
        super.init(record)
        self.priority = record["priority"] as! UInt64
    }
    
    required init(_ rst: FMResultSet) {
        super.init(rst)
    }
    
    required init(title:String, desc:String = ""){
        super.init(title: title, desc: desc)
    }
    
    func addChild(_ child:Task){
        if(!children.contains(child)){
            children.append(child)
        }
    }
    
    func removeChild(_ child:Task){
        if let index = children.index(where: { (task) -> Bool in
            return child == task
        }){
            children.remove(at: index)
        }
    }
    
    override func create() -> Int64? {
        if localStorage.exe("insert into Story (title, desc, priority) values(?, ?, ?)", args: [title, desc, priority]){
            return localStorage.lastInsertRowId
        }
        return nil
    }
    
    override func update() {
        _ = localStorage.exe("update Story set (title, desc, priority) = (?, ?, ?) where id=?", args: [title, desc, priority,  id!])
    }
    
    override func setRecordProperties(_ record: CKRecord) -> CKRecord {
        record["title"] = self.title! as CKRecordValue
        record["desc"] = self.desc! as CKRecordValue
        record["priority"] = self.priority as CKRecordValue
        return record
    }
}


