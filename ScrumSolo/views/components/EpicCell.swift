//
//  EpicCell.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 02/08/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit

class EpicCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    var color:UIColor{
        get{
            return UIColor(cgColor: self.bgView.layer.borderColor!)
        }
        set{
            self.bgView.layer.borderColor = newValue.cgColor
            self.closeBtn.setTitleColor(newValue, for: .normal)
            self.bgView.layer.setNeedsDisplay()
        }
    }
    
//    override func prepareForInterfaceBuilder() {
//        self.color = .red;
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 5
        self.bgView.backgroundColor = .clear
//        self.layer.masksToBounds = true
        self.bgView.layer.borderWidth = 1
        self.color = .red
        
        self.closeBtn.addTarget(self, action: #selector(onRemove(sender:)), for:.touchUpInside )
    }
    
    @objc func onRemove(sender:UIButton){
        print("will remove this epic \(self.title.text)")
    }
    
    

}
