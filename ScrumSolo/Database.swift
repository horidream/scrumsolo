//
//  Database.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 09/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import FMDB



class Database {
    var path:String = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let path = paths.first!.appending("/test.db")
        return path
    }()
    
    
    var db:FMDatabase
    init(){
        db = FMDatabase(path: path)
        db.open()
        db.executeStatements("CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY, title TEXT)")
        
    }
}
