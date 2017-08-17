//
//  EpicCLVC.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 02/08/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "EpicCell"

class EpicCLVC: UICollectionViewController {
    
    var epics = "RandomRiches,Hello World, sbX 4.7, ScrumSolo 1.0".split(separator: ",")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Epic Stories"

        self.collectionView?.register(UINib(nibName:"EpicCell", bundle:nil), forCellWithReuseIdentifier: "EpicCell")
//        let flowLayout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        flowLayout.estimatedItemSize = CGSize(width: 120, height: 38)
        
        
        
    }

    @IBAction func onEdit(_ sender: Any) {
        self.isEditing = !self.isEditing
        self.collectionView?.reloadSections([0])
    }
    

    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let (a, b) = (epics[sourceIndexPath.row], epics[destinationIndexPath.row])
        epics[sourceIndexPath.row] = b
        epics[destinationIndexPath.row] = a
//        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return epics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpicCell
        let word = epics[indexPath.row]
        cell.title.text = String(word)
        cell.title.sizeToFit()
        cell.color = .red;
        cell.isEditing = self.isEditing
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension  EpicCLVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let str = epics[indexPath.row]
        var txtSize = (str as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize:17)])
        txtSize.width += 28
        txtSize.height += 16
        return txtSize
    }
}
