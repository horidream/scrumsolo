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
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bg = UIView()
        bg.backgroundColor = .black
        sub = UIView(frame: self.bounds.insetBy(dx: 5, dy: 5))
        bg.addSubview(sub)
        self.contentView.addSubview(bg)
        self.backgroundColor = .clear
        self.selectionStyle = .none
//        self.backgroundView = bg
//        self.selectedBackgroundView = bg
    }
    
    
    override func layoutSubviews() {
        self.backgroundView?.frame = self.bounds
        sub.frame = self.bounds.insetBy(dx: 2, dy: 2)
        let ly = sub.layer
//        ly.backgroundColor = UIColor.yellow.cgColor
//        ly.masksToBounds = true
        ly.cornerRadius = 6
        ly.borderColor = UIColor.lightGray.cgColor
        ly.borderWidth = 1.0
        ly.shadowRadius = 5.0
        ly.shadowColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
