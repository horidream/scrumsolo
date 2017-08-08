//
//  EpicCell.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 02/08/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
@IBDesignable
class EpicCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    var color:UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set{
            self.layer.borderColor = color.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        self.color = .red;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 2
    }
    
    

}
