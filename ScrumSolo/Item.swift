//
//  Item.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 09/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation




protocol LocalManageable {
    var db:Database { get }
    func save()
    func delete()
}

extension LocalManageable{
    var db:Database  {
        return Const.db
    }
}

enum ItemType:String{
    case story, task, undefined
}

class Item{
    var id:UInt64?
    var title:String
    var type:ItemType = .undefined
    var parent:Item?
    var children:[Item] = []
    
    static func fetch(_ sql: String, args: [Any]! = nil) -> [Item] {
        return Const.db.query(sql, args: args) { (rst) -> Item in
            return Item("ok")
        }
    }
    
    init(_ title:String){
        self.title = title
    }
}



