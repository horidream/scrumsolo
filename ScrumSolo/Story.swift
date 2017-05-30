//
//  Story.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 27/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import Shifu


class Task:Composite{
    var parent:Story?
    var children: [NSNull]? = nil
}

class Story:Composite{
    var parent: NSNull? = nil
    var children: [Task]? = []
}
