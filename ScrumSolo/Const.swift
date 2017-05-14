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
    static var dbm:DBManager = DBManager(filename: "scrumfolo.db")
    static var cloud:CKDatabase = {
        let container = CKContainer.default()
        return container.privateCloudDatabase
    }()
}
