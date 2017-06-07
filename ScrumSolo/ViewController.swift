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
        let query = CKQuery(recordType: "Story", predicate: NSPredicate(value: true))
        Story.cloudQuery(query){ (stories) in
            stories.forEach({ (story) in
                print(story.priority)
            })
        }
    }
}
