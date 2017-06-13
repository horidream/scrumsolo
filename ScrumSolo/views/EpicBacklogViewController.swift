//
//  ViewController.swift
//  ScrumSolo
//
//  Created by Baoli.Zhai on 08/05/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
import CloudKit

class EpicBacklogViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.title = "Epic Backlogs"
        self.tableView.register(UINib(nibName: "CreateNewCell", bundle: nil), forCellReuseIdentifier: "EpicNew")
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
    }
}


extension EpicBacklogViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0,2:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpicHead")!
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpicCell")!
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpicNew")!
            return cell
        default:
            return UITableViewCell()
        }
    }
}
