//
//  StoryTableViewCell.swift
//  ScrumSolo
//
//  Created by Baoli.Zhai on 15/06/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit
import BadgeSwift

class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var badge: BadgeSwift!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
