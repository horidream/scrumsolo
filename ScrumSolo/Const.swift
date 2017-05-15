//
//  Const.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 11/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit

struct Const{
    static var localStorage:LocalStorage = LocalStorage(filename: "scrumfolo.db")
    static var cloudStorage:CloudStorage = CloudStorage()
    
}
