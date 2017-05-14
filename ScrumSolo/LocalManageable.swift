//
//  LocalManageable.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 15/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import FMDB

protocol LocalManageable {
    var dbm:DBManager { get }
    func save()
    func delete()
    init(_ rst:FMResultSet)
}

extension LocalManageable{
    var dbm:DBManager  {
        return Const.dbm
    }
}
