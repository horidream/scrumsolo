//
//  Task.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 05/06/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation

class Task:ManageableItem, Equatable{
    weak var parent:Story?
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.title == rhs.title  && lhs.descriptions == rhs.descriptions
    }
}
