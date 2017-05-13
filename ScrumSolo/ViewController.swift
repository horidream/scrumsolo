//
//  ViewController.swift
//  ScrumSolo
//
//  Created by Baoli.Zhai on 08/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dbm = Const.dbm
        Const.dbm.clear()
        for i in 1...3{
            Item("item \(i)").save()
        }
        dbm.commit()
        let allItems = Item.fetch("select * from items")
        print("get \(allItems.count) items: \(allItems)")
        let first = allItems.first
        first?.title = "Harry Potter"
        first?.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            print("get \(allItems.count) items: \(allItems)")
            
        }
        
    }

    


}

