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


class Story:ManageableItem{
    var priority:UInt64 = 0
    var children:[Task] = []
    
    
    
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
        if localStorage.exe("insert into Story (title, descriptions, state, priority) values(?, ?, ?, ?)", args: [title, descriptions, state.rawValue, priority]){
            self.id = localStorage.lastInsertRowId
        }
        return nil
    }
    
    override func update() {
        _ = localStorage.exe("update Story set (title, descriptions, state, priority) = (?, ?, ?, ?) where id=?", args: [title, descriptions, state.rawValue, priority,  id!])
    }
    
    override func setRecordProperties(_ record: CKRecord) -> CKRecord {
        record["title"] = self.title! as CKRecordValue
        record["descriptions"] = self.descriptions! as CKRecordValue
        record["state"] = self.state.rawValue as CKRecordValue
        record["priority"] = self.priority as CKRecordValue
        return record
    }
}


