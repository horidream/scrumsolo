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
    var epics:[Epic] = []
    override func viewDidLoad() {
        self.title = "Epic Backlogs"
        self.tableView.register(UINib(nibName: "CreateNewCell", bundle: nil), forCellReuseIdentifier: "EpicNew")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        self.tableView.separatorStyle = .none
        epics = Epic.fetch("select * from Epic")
        self.tableView.reloadData()
    }
}


extension EpicBacklogViewController:UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if(offset.y < 0){
            let headerView = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!
//            var frame = attr.frame
//            frame.size.height = max(0, headerReferenceSize.height + fabs(offset.y))
//            frame.origin.y += offset.y
//            attr.frame = frame
            let frame = CGRect(x: 0, y: offset.y, width: scrollView.contentSize.width, height:scrollView.contentSize.width * 256 / 375 - offset.y )
            headerView.frame = frame
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (2, _):
            print("crate new cell")
            let alert = UIAlertController(title: "Create New Epic", message: "xxx", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { (tf) in
                
                tf.placeholder = "Epic Story Name"
            })
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
                if let title = alert.textFields?.first?.text{
                    let epic = Epic(title: title)
                    epic.save()
                    print(epic)
                    if(epic.id != nil){
                        self.epics.append(epic)
                        self.tableView.reloadData()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
               self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        default:()
            
        }
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
            return epics.count
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
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpicCell") as? EpicTableViewCell{
                cell.title.text = epics[indexPath.row].title
                return cell
            }
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpicNew")!
            return cell
        default:()
        }
        return UITableViewCell()
    }
}
