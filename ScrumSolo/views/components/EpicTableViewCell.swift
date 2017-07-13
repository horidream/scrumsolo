//
//  EpicTableViewCell.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 17/06/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
import Shifu

class EpicTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    var sub:UIView!
    
    
    
    
    
}


// layout decoration
extension EpicTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bg = UIView()
        bg.backgroundColor = .black
        sub = UIView(frame: self.bounds.insetBy(dx: 5, dy: 5))
        bg.addSubview(sub)
        self.contentView.addSubview(bg)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    
    override func layoutSubviews() {
        self.backgroundView?.frame = self.bounds
        sub.frame = self.bounds.insetBy(dx: 2, dy: 2)
        let ly = sub.layer
        ly.cornerRadius = 6
        ly.borderColor = UIColor.lightGray.cgColor
        ly.borderWidth = 1.0
        ly.shadowRadius = 5.0
        ly.shadowColor = UIColor.lightGray.cgColor
    }
}
