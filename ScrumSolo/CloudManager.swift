//
//  CloudManager.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 14/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import Foundation
import CloudKit

class CloudManager{
    private var container:CKContainer = CKContainer.default()
    private var privateDB:CKDatabase{
        return container.privateCloudDatabase
    }
    
}
