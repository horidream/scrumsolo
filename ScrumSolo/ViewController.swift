//
//  ViewController.swift
//  ScrumSolo
//
//  Created by Baoli.Zhai on 08/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
import CloudKit
import Alamofire
import SwiftyJSON



class ViewController: UIViewController {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let s = Story(title:"OK", descriptions:"...")
        let s2 = Story(title:"hello", descriptions:"world")
        [s, s2].cloudSave { (res) in
            print(res)
        }
    }
}
