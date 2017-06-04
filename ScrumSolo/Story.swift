//
//  Story.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 27/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import Shifu

class Node<T> {
    var value:T
    weak var parent:Node?
    var children:[Node]?
    init(_ value:T){
        self.value = value
    }
}

extension Node{
    func addChild(_ child:Node)->Node{
        children?.append(child)
        return child
    }
}

extension Node where T:Equatable{
    func removeChild(_ child:Node) -> Node?{
        if let index = children?.index(where: { (someNode) -> Bool in
            return someNode.value == child.value
        }){
            return children?.remove(at: index)
        }
        return nil
    }
}

enum ItemType{
    case story
}
typealias Story = Node<String>


//class Task:Item, Composite{
//    var parent:Story?
//    var children: [NSNull]? = nil
//}
//
//class Story:Item, Composite{
//    var parent: NSNull? = nil
//    var children: [Task]? = []
//}
