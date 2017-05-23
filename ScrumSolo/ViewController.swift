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
    var requestManager:SessionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://api.github.com/repos/vuejs/vue").responseJSON { (response) in

            print((response.result.value as? Dictionary<String, Any>)?["stargazers_count"])
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alamofire.request("https://httpbin.org/image/png")
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                print(response)
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    let iv = UIImageView(image: image)
                    print(iv)
                    self.view.addSubview(iv)
                }
        }
    }
}
