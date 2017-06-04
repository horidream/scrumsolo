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
        ls.create(tableName: "items", schema: "id INTEGER PRIMARY KEY, title TEXT, type INTEGER DEFAULT 0")
        return ls
    }
    
    static let cloudStorage:CloudStorage = CloudStorage()
}
