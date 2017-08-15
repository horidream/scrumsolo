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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Epic Stories"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(UINib(nibName:"EpicCell", bundle:nil), forCellWithReuseIdentifier: "EpicCell")
        let flowLayout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        // Do any additional setup after loading the view.
    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpicCell
        let arr = "This is an online brainstorming tool I made that generates random words".split(separator: " ")
        let word = arr[Int(arc4random_uniform(UInt32(arr.count)))]
        cell.title.text = String(word)
        cell.title.sizeToFit()
        cell.color = .red;
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
