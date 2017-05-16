//
//  ViewController.swift
//  ScrumSolo
//
//  Created by Baoli.Zhai on 08/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("start rendering")
        DispatchQueue.global().async { [unowned self] in
            print("try saving")
            self.trySave()
        }

    }
    func tryLoad(){
        let query = CKQuery(recordType: "item", predicate: NSPredicate(value: true))
        Const.cloudStorage.query(query) { (records) in
            let recordIds = records.map{ $0.recordID }
            Const.cloudStorage.modify(recordsToSave: nil, recordIDsToDelete: recordIds, callback: { (records, recordIds, error) in
                print("\(records)\n\(recordIds)\n\(error)")
            })
        }
    }
    func trySave(){
        Const.localStorage.clear()
        for i in 1...3{
            Item("item \(i)").save()
        }
        let allItems = Item.fetch("select * from items")
        print("get \(allItems.count) items: \(allItems)")
        let first = allItems.first
        first?.title = "Harry Potter"
        first?.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("get \(allItems.count) items: \(allItems)")
            let records = allItems.map({ (item) -> CKRecord in
                let record = CKRecord(recordType: "item")
                record["title"] = item.title as CKRecordValue
                return record
            })
            Const.cloudStorage.modify(recordsToSave: records, callback: { (records, recordIds, error) in
                print("record \(String(describing: records)) saved")
            })
            
            
            
        }
    }

    


}

