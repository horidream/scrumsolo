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
    
    private var db:FMDatabase
    init(filename:String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let path = paths.first!.appending("/\(filename)")
        db = FMDatabase(path: path)
        db.open()
        
        db.executeStatements("CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY, title TEXT, type INTEGER DEFAULT 0)")
    }
    
    func exe(_ sql:String, args:[Any]! = nil)->Bool{
        do {
            try db.executeQuery(sql, values: args).next()
            return true
        }catch _ {
            return false
        }
    }
    
    func query<T>(_ sql:String, args:[Any]! = nil, map block:(FMResultSet)->T?)->Array<T>{
        var result:Array<T> = []
        if let rs = try? db.executeQuery(sql, values: args) {
            while rs.next() {
                if let r = block(rs){
                    result.append(r)
                }
            }
        }
        return result
    }
    
    func clear(){
        db.executeStatements("DROP TABLE IF EXISTS items")
    }
}
