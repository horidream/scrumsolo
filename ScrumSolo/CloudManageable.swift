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
    var cloudManager:CloudManager { get }
    func save()
    func delete()
    init(_ rst:CKRecord)
}
