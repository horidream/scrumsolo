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






enum ItemType:String{
    case story, task, undefined
}

class Item: LocalManageable, CustomStringConvertible{
    var id:Int64?
    var title:String
    var type:ItemType = .undefined
    var parent:Item?
    var children:[Item] = []
    
    static func fetch(_ sql: String, args: [Any]! = nil) -> [Item] {
        return Const.dbm.query(sql, args: args) { (rst) -> Item in
            return Item(rst)
        }
    }
    
    init(_ title:String){
        self.title = title
    }
    
    required init(_ rst: FMResultSet) {
        self.id = rst.longLongInt(forColumn: "id")
        self.title = rst.string(forColumn: "title")
    }

    func delete() {
        if let id = id{
            _ = dbm.exe("delete from items where id = ?", args: [id])
        }
    }

    func save() {
        if let id = id,  dbm.rowExists(id: id){
            _ = dbm.exe("update items set title=? where id=?", args: [title, id])
        }else{
            if dbm.exe("insert into items (title) values(?)", args: [title]){
                self.id = dbm.lastInsertRowId
            }
        }
    }
   
    var description: String{
        return "\(String(describing: id ?? 0))-\(self.title)"
    }
}



