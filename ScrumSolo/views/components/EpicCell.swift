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
            self.title.textColor = newValue
            self.closeBtn.setTitleColor(newValue, for: .normal)
            self.bgView.layer.setNeedsDisplay()
        }
    }
    
    var isEditing:Bool = false{
        didSet{
            self.closeBtn.isHidden = !isEditing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 5
        self.bgView.backgroundColor = .clear
//        self.layer.masksToBounds = true
        self.bgView.layer.borderWidth = 1
        self.color = .red
        self.isEditing = false
        self.closeBtn.backgroundColor = UIColor.red.withAlphaComponent(0.01)
        self.closeBtn.addTarget(self, action: #selector(onRemove(sender:)), for:.touchUpInside )
    }
    
    @objc func onRemove(sender:UIButton){
        print("will remove this epic \(String(describing: self.title.text))")
    }
    
    

}
