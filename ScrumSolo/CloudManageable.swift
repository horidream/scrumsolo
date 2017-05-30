//
//  CloudManageable.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 15/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit

struct AsyncResponse{
    let success:Bool
    let payload:Any!
}

protocol CloudManageable {
    var cloudStorage:CloudStorage { get }
    func cloudSave(complete:@escaping(AsyncResponse)->Void)
    func cloudDelete(complete:@escaping(AsyncResponse)->Void)
    init(_ record:CKRecord)
}

extension CloudManageable{
    var cloudStorage:CloudStorage{
        return Const.cloudStorage
    }
}
