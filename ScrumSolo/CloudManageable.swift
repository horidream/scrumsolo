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
    func cloudSave()
    func cloudDelete()
    init(_ record:CKRecord)
}
