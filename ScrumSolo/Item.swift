//
//  Item.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 09/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation


enum ItemType:String{
    case story, task, undefined
}

protocol ItemTypeDefined{
    var type:ItemType {get}
}


class Item{
    var title:String
    var parent:Item?
    init(_ title:String){
        self.title = title
    }
}



class Task:Item,ItemTypeDefined{
    let type:ItemType = .task
    
}

class Story:Item,ItemTypeDefined{
    let type:ItemType = .story
    var children:[Item] = []
}
