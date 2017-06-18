//
//  Const.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 11/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit

struct Shared{
    static var localStorage:LocalStorage {
        let ls = LocalStorage(filename: "scrumfolo.db")
//        _ = ls.exe("DROP TABLE IF EXISTS Story")
//        _ = ls.exe("DROP TABLE IF EXISTS Task")
        ls.create(tableName: "Epic", schema: "id INTEGER PRIMARY KEY, title TEXT, descriptions TEXT, state INTEGER DEFAULT 0, priority INTEGER DEFAULT 0")
        ls.create(tableName: "Task", schema: "id INTEGER PRIMARY KEY, title TEXT, state INTEGER DEFAULT 0, descriptions TEXT")
        ls.create(tableName: "Story", schema: "id INTEGER PRIMARY KEY, title TEXT, descriptions TEXT, state INTEGER DEFAULT 0, priority INTEGER DEFAULT 0")
        ls.create(tableName: "Task", schema: "id INTEGER PRIMARY KEY, title TEXT, state INTEGER DEFAULT 0, descriptions TEXT")
        return ls
    }
    
    static let cloudStorage:CloudStorage = CloudStorage()
}
