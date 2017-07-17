//
//  Const.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 11/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit
import Shifu


struct Shared{
    static let ls = LocalStorage(filename: "scrumfolo.db")
    static var localStorage:LocalStorage {
//        drop("Epic", "Story", "Task")
        ls.create(tableName: "Epic", schema: "id INTEGER PRIMARY KEY, title TEXT, desc TEXT, createdtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, priority INTEGER DEFAULT 0")
        ls.create(tableName: "Story", schema: "id INTEGER PRIMARY KEY, title TEXT, desc TEXT, state INTEGER DEFAULT 0, priority INTEGER DEFAULT 0")
        ls.create(tableName: "Task", schema: "id INTEGER PRIMARY KEY, title TEXT, state INTEGER DEFAULT 0, desc TEXT")
        return ls
    }
    
    static func drop(_ tableNames:String...){
        tableNames.forEach{
            tableName in
            _ = ls.exe("DROP TABLE IF EXISTS \(tableName)")
        }
    }
    
    static let cloudStorage:CloudStorage = CloudStorage()
}
