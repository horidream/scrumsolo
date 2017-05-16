//
//  CloudManageable.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 15/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit



protocol CloudManageable {
    var cloudStorage:CloudStorage { get }
    func cloudSave(complete:@escaping()->Void)
    func cloudDelete(complete:@escaping()->Void)
    init(_ record:CKRecord)
}

extension CloudManageable{
    var cloudStorage:CloudStorage{
        return Const.cloudStorage
    }
}
